import yaml
import msal
import os
import time
from django.conf import settings

stream = open(settings.BASE_DIR / 'calendar_auth.yaml', 'r')
setting = yaml.load(stream, yaml.SafeLoader)
#print(setting)

def load_cache(request):
	cache = msal.SerializableTokenCache()
	if request.session.get('token_cache'):
		cache.deserialize(request.session['token_cache'])

	return cache

def save_cache(request, cache):
	# If cache has changed, persist back to session
	if cache.has_state_changed:
		request.session['token_cache'] = cache.serialize()

def get_msal_app(cache=None):
	# Initialize the MSAL confidential client
	#print(setting['app_id'])
	auth_app = msal.ConfidentialClientApplication(
		setting['app_id'],
		authority=setting['authority'],
		client_credential=setting['app_secret'],
		token_cache=cache)
	# auth_app = msal.ConfidentialClientApplication("212e9fa3-c7f9-4df0-922f-7c8897844527",
	# 	"https://login.microsoftonline.com/common",".1M6e37_jxnq.mre_.NSUHP.2QW.R0F2RE",
	# 	"")

	return auth_app

# Method to generate a sign-in flow
def get_sign_in_flow():
	auth_app = get_msal_app()

	return auth_app.initiate_auth_code_flow(
		setting['scopes'],
		redirect_uri=setting['redirect'])

# Method to exchange auth code for access token
def get_token_from_code(request):
	cache = load_cache(request)
	auth_app = get_msal_app(cache)
	# Get the flow saved in session
	flow = request.session.pop('auth_flow', {})
	result = auth_app.acquire_token_by_auth_code_flow(flow, request.GET)
	save_cache(request, cache)
	return result


def store_user(request, user):
	request.session['user'] = {
	'is_authenticated': True,
	'name': user['displayName'],
	'email': user['mail'] if (user['mail'] != None) else user['userPrincipalName'],
	'timeZone': user['mailboxSettings']['timeZone']
	}

def get_token(request):
	cache = load_cache(request)
	auth_app = get_msal_app(cache)

	accounts = auth_app.get_accounts()
	print(accounts)
	result={}
	if accounts:
		result = auth_app.acquire_token_silent(
	  	setting['scopes'],
	  	account=accounts[0]
		)

	save_cache(request, cache)

	return result['access_token']

def remove_user_and_token(request):
	if 'token_cache' in request.session:
		del request.session['token_cache']

	if 'user' in request.session:
		del request.session['user']