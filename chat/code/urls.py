#from django.conf.urls import url
from django.urls import path
from .views import user_list,room,index,upload_file,get_file


urlpatterns = [
    path('', index, name='index'),
    path('room/<str:room_name>/', room, name='room'),
    path('uploads/',upload_file,name='uploads/'),
    path('get_file/<str:file_name>',get_file,name='get_file/')
]
