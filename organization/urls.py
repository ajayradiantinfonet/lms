from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('create_organization/', views.CreateOrganization.as_view(), name='create_organization'),
    # path('test/',views.test,name='test'),
    # path('create_group/',views.create_group,name='create_group'),

]