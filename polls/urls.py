#-*- coding: utf-8 -*-
from django.conf.urls import url
from django.urls import path
from . import views

app_name = "polls"

urlpatterns = [
	path('add_poll',views.add_poll,name='add_poll'),
	path('get_poll',views.get_poll,name='get_poll'),
	path('get_poll_analytics',views.get_poll_analytics,name='get_poll_analytics'),
	path('store_answer_of_poll',views.store_answer_of_poll,name='store_answer_of_poll'),
    url(r'^$', views.IndexView.as_view(), name='index'),
    url(r'^(?P<pk>\d+)/$', views.DetailView.as_view(), name='detail'),
    url(r'^(?P<pk>\d+)/results/$', views.ResultsView.as_view(), name='results'),
    url(r'^(?P<poll_id>\d+)/vote/$', views.vote, name='vote'),
]
