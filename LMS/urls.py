"""lms URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
'''from django.contrib import admin
from django.urls import path

urlpatterns = [
    path('admin/', admin.site.urls),

]
'''

from django.contrib import admin
from django.urls import path, include
from django.conf.urls import include, url
from django.conf.urls.static import static
from .settings import STATIC_URL,STATIC_ROOT,MEDIA_URL,MEDIA_ROOT
#import forms_builder.forms.urls
#from django.conf.urls import  url
#import pulpo_forms
# from wagtail.admin import urls as wagtailadmin_urls
# from wagtail.core import urls as wagtail_urls
# from wagtail.documents import urls as wagtaildocs_urls

urlpatterns = [
    #path('admin/doc/', include('django.contrib.admindocs.urls')),
    path('superuseradmin/', admin.site.urls),
    #path('', include('accounts.urls'),namespace="accounts"),
    # path('mainapp/',include (('mainapp.urls','mainapp'), namespace='mainapp')),
    path("assesapi/",include(('assesapi.urls','assesapi'), namespace='assesapi')),
    path('accounts/', include (('accounts.urls','accounts'), namespace='accounts')),
    path('',include (('userlms.urls','userlms'), namespace='userlms')),
    path('assesment/', include (('preassesment.urls','assesment'), namespace='assesment')),
    path('admin/',include(('customadmin.urls','customadmin'),namespace='customadmin')),
    path('grades/',include(('grades.urls','grades'),namespace='grades')),
    path('poll/',include(('polls.urls','poll'),namespace='poll')),
    # path('chat/',include(('chat.urls','chat'),namespace='chat')),
    #url(r'^forms/', include(forms_builder.forms.urls)),
    #url(r'^forms/', include('pulpo_forms.urls'), name='base'),
    #path("forms/", include(("form.urls"),namespace='form'))
    #path('cms/', include(wagtailadmin_urls)),
    #path('documents/', include(wagtaildocs_urls)),
    #path('pages/', include(wagtail_urls)),
    #path('custompermission/', include(('custompermission.urls','custompermission'),namespace='custompermission')),
    #path('customadmin/',include(('customadmin.urls','customadmin'),namespace='customadmin')),
    #path('polls/',include('polls.urls','polls')),
    #path('',include(('organization.urls','organization'),namespace='organization')),
] + static(MEDIA_URL, document_root=MEDIA_ROOT)
#+ static(STATIC_URL, document_root=STATIC_ROOT)

# if DEBUG:
#     from django.contrib.staticfiles.urls import staticfiles_urlpatterns
#     urlpatterns += staticfiles_urlpatterns()
