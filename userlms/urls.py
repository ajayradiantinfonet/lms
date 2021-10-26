from django.contrib import admin
from django.urls import path,re_path
from . import views

urlpatterns = [
    
    path('contact/',views.contactus ,name="contactus"),
    path('team/',views.team ,name="team"),
    path('mission/',views.mission ,name="mission"),
    path('about/',views.aboutus ,name="aboutus"),
    path('', views.home ,name='home'), 
    path('fav/<int:id>/',views.fav,name='fav'),
    path('Wishlistfun/',views.Wishlistfun,name='Wishlistfun'),
    path('course_details/<int:pk>/details/',views.CourseDetails.as_view(),name='course_details'),
    path('course_details/',views.AllCourse.as_view(),name='course_details'),
    path('my/',views.useradmin,name='my'),
    path('my/<int:courseid>/',views.course_dashboard,name='my'),
    path('check_course/',views.check_course),
    path('is_open/',views.is_open,name='is_open'),
    path('open_next_topic',views.open_next_topic,name='open_next_topic'),
    path('activity_completed',views.activity_completed,name='activity_completed'),
    path('add_discussion',views.add_discussion,name='add_discussion'),
    path('add_notes/',views.add_notes,name='add_notes'),
    path('show_notes/',views.show_notes,name="show_notes"),
    path('get_online_user',views.get_online_user,name='get_online_user'),
    path('show_spin_activity',views.show_spin_activity,name='show_spin_activity'),
    path('show_spin_activity/<int:pk>/',views.show_spin_activity,name='show_spin_activity'),
    path('get_activity/',views.get_activity,name='get_activity'),
    path('get_activity/<int:pk>/',views.get_activity,name='get_activity'),
    path('submit_assignment',views.submit_assignment,name='submit_assignment'),
    path('course_list/',views.course_list,name='course_list'),
    path('certificate/',views.certificate,name='certificate'),
    path('download_certificate/',
        views.download_certificate,name='download_certificate'),
    path('user_profile/',views.user_profile,name='user_profile'),
    path('get_last_opened_topic',views.get_last_opened_topic,name='get_last_opened_topic'),
    path('profile_submit/<int:pk>/',views.ProfileSubmit.as_view(),name='profile_submit'),
]