from django.urls import path

from django.conf.urls import url

from . import views
urlpatterns=[
url(r'^addquestion/$', views.add_question, name="add_question"),

url(r'^addquestion/(?P<question_id>\d+)/$', views.add_question,
        name="add_question"),

url(r'^addquiz/(?P<course_id>\d+)/(?P<topic_id>\d+)/$',
        views.add_quiz, name='add_quiz'),


url(r'^addquiz/',views.add_quiz, name='add_quiz'),

path('all_quiz/',views.AllQuiz.as_view(),name='all_quiz'),

url(r'^edit_quiz_ac/(?P<course_id>\d+)/(?P<topic_id>\d+)/(?P<quiz_id>\d+)/$',views.add_quiz, name='edit_quiz_ac'),

path('get_next_question/<int:answerpaperid>/<int:userid>/<int:questionid>/',
    views.get_next_question,
    name='get_next_question'),

# url(r'^start/(?P<questionpaper_id>\d+)/(?P<module_id>\d+)/'
#         '(?P<course_id>\d+)/$', views.start, name="start_quiz"),

# url(r'^(?P<q_id>\d+)/skip/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
#         '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$',
#         views.skip, name="skip_question"),

url(r'^(?P<q_id>\d+)/skip/(?P<next_q>\d+)/(?P<attempt_num>\d+)/'
        '(?P<module_id>\d+)/(?P<questionpaper_id>\d+)/$',
        views.skip, name="skip_question"),

url(r'^complete/$', views.complete, name="complete"),

url(r'^complete/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
        '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$', views.complete,
        name="complete"),

url(r'^complete_api/$', views.complete_api, name="complete_api"),

url(r'^complete_api/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
        '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$', views.complete_api,
        name="complete_api"),


url(r'^(?P<q_id>\d+)/check/$', views.check, name="check"),

# url(r'^(?P<q_id>\d+)/check/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
#         '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$',
#         views.check, name="check"),


url(r'^check/(?P<q_id>\d+)/(?P<attempt_num>\d+)/(?P<questionpaper_id>\d+)/$',
        views.check, name="check"),

url(r'^check_and_next_api/(?P<q_id>\d+)/(?P<attempt_num>\d+)/(?P<questionpaper_id>\d+)/$',
        views.check_and_next_api, name="check_and_next_api"),

url(r'^start/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
        '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$', views.start,
        name="start_quiz"),

path('show_q/<int:questionid>/<int:paperid>/',views.show_question,
    name='show_q'),


url(r'^start/(?P<questionpaper_id>\d+)/$', views.start, name="start_quiz"),

# url(r'^start/(?P<questionpaper_id>\d+)/(?P<module_id>\d+)/'
#         '(?P<course_id>\d+)/$', views.start, name="start_quiz"),

url(r'^view_answerpaper/(?P<questionpaper_id>\d+)/(?P<course_id>\d+)$',
        views.view_answerpaper, name='view_answerpaper'),

#url(r'^results/$', views.results_user),



url(r'^quit/(?P<attempt_num>\d+)/(?P<module_id>\d+)/'
        '(?P<questionpaper_id>\d+)/(?P<course_id>\d+)/$', views.quit,
        name="quit_quiz"),



# url(r'^designquestionpaper/(?P<course_id>\d+)/(?P<quiz_id>\d+)/'
#         '(?P<questionpaper_id>\d+)/$',
#         views.design_questionpaper, name='designquestionpaper'),

url(r'^designquestionpaper/(?P<quiz_id>\d+)/'
       '(?P<questionpaper_id>\d+)/$',views.design_questionpaper, name='designquestionpaper'),


# url(r'^designquestionpaper/(?P<course_id>\d+)/(?P<quiz_id>\d+)/$',
#         views.design_questionpaper, name='designquestionpaper'),


url(r'^designquestionpaper/(?P<quiz_id>\d+)/$',
        views.design_questionpaper, name='designquestionpaper'),


url(r'^questions/$', views.show_all_questions,
        name="show_questions"),

url(r'^question/test/(?P<question_id>\d+)',
        views.test_question, name="test_question"),
    

]
