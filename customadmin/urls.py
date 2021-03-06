from django.contrib import admin
from django.urls import path,re_path
from . import views
from .views import EmployeeUploadView


urlpatterns = [
    #add college functionality
    path('clg_home/',views.clg_home, name="clg_home"),
    path('create_College/',views.CreateCollege.as_view(),name='create_College'),
    path('view_College/<int:pk>/',views.ViewClg.as_view(),name='view_College'),
    path('edit_college/',views.EditCollege.as_view(),name='edit_college'),
    path('edit_college/<int:pk>/',views.EditCollege.as_view(),name='edit_college'),
    path('delete_college/<int:pk>/',views.DeleteCollege.as_view(),
        name='delete_college'),
    path('delete_college/',views.DeleteCollege.as_view(),
        name='delete_college'),    

    path('test/', views.test, name="test"),
    path('notification_add/',views.Notification_add,name='Notification_add'),

    path('logout/', views.logoutUser, name="logout"),
    path('addurlactivity/',views.urlactivity,name="add_urlactivity"),
    path('addurlactivity/<int:pk>/',views.urlactivity,name="add_urlactivity"),
    path('edit_urlactivity/<int:pk>/',views.edit_urlactivity,name="edit_urlactivity"),
    path('addpdfactivity/',views.pdfactivity,name="add_pdfactivity"),
    path('addpdfactivity/<int:pk>/',views.pdfactivity,name="add_pdfactivity"),
    path('edit_pdfactivity/<int:pk>/',views.edit_pdfactivity,name="edit_pdfactivity"),


    path('addpptactivity/',views.pptactivity,name="add_pptactivity"),
    path('addpptactivity/<int:pk>/',views.pptactivity,name="add_pptactivity"),
    path('adddocactivity/',views.docactivity,name="add_docactvity"),
    path('adddocactivity/<int:pk>/',views.docactivity,name="add_docactvity"),

    path('',views.admin_home,name='admin_home'),
    
    path('bulkupload/', views.bulkupload, name='bulkupload'),
    path('importemployee/', EmployeeUploadView.as_view(), name='importemployee'),
    # path('user_permission/',views.user_permission,name='user_permission'),
    path('all_permission/',views.all_permission,name='all_permission'),
    path('assign_permission/',views.Assign_permission.as_view(),name='assign_permission'),
    path('show_user_permission/<int:pk>', views.Showuserperm, name='show_user_permission'),
    path('create_permission/',views.CreatePermission.as_view(),name='create_permission'),
    path('create_organization/',views.CreateOrganization.as_view(),name='create_organization'),
    path('view_organization/<int:pk>/',views.ViewOrg.as_view(),name='view_organization'),
    path('edit_organization/',views.EditOrganization.as_view(),name='edit_organization'),
    path('edit_organization/<int:pk>/',views.EditOrganization.as_view(),name='edit_organization'),
    path('create_organization_user/', views.CreateOrganizationUser.as_view(), name='create_organization_user'),
    path('create_college_user/', views.CreateCollegeUser.as_view(), name='create_college_user'),
    path('delete_organization/',views.DeleteOrganization.as_view(),
        name='delete_organization'),
    path('delete_organizationn/',views.DeleteOrganizationn.as_view(),
        name='delete_organizationn'),    
    path('delete_organization/<int:pk>/',views.DeleteOrganization.as_view(),
        name='delete_organization'),
    path('delete_organizationn/<int:pk>/',views.DeleteOrganizationn.as_view(),
        name='delete_organizationn'),    
    path('save_org_cer_img/',views.save_org_cer_img,name='save_org_cer_img'),
    # path('create_course/',views.CreateCourse.as_view(),name='create_course'),
    #path('all_course/',views.AllCourse.as_view(),name='all_course'),
    #path('all_course/',views.AllCourse.as_view(),name='all_course'),
    path('add_topic/',views.AddTopic.as_view(),name='add_topic_c'),
    path('add_topic/<int:courseid>/',views.AddTopic.as_view(),name='add_topic_c'),
    path('add_topic/',views.AddTopic.as_view(),name='add_topic'),
    path('all_topic/',views.AllTopic.as_view(),name='all_topic'),
    path('set_order_topic/',views.SetOrderTopic.as_view(),name='set_order_topic'),
    #path('all_topic/<int:courseid>/',views.AllTopic.as_view(),name='all_topic'),
    path('all_topic/<int:pk>/edit/',views.EditTopic.as_view(),name='edit_topic'),
    path('all_topic/<int:pk>/delete/',views.DeleteTopic.as_view(),name='delete_topic'),
    path('delete_topic/',views.delete_topic,name='delete_topic'),
    #path('edit_topic/<int:pk>/',views.edit_topic,name='edit_topic'),
    path('add_activity/',views.AddActivity.as_view(), name='add_activity'),
    path('add_activity/<int:topicid>/',views.AddActivity.as_view(),name='add_activity_for_topic'),
    path('course_detail/<int:pk>',views.CourseDetail.as_view(), name='course_detail'),
    #path('course_enroll/<int:pk>',views.CourseEnroll.as_view(),name='course_enroll'),
    path('schedule_session/',views.ScheduleSession.as_view(),name='schedule_session'),
    path('create_group/',views.CreateGroup.as_view(),name='create_group'),
    path('show_group/',views.show_group,name="show_group"),
    path('addgrade/<int:id>/',views.addgrade,name='addgrade'),
    path('all_activity_type/',views.AllActivityType.as_view(),name='all_activity_type'),
    path('add_activity_type/',views.AddActivityType.as_view(),name='add_activity_type'),
    path('add_activity_type/<int:pk>/delete/',views.DeleteActivityType.as_view(),name='add_activity_type'),
    path('add_activity_type/<int:pk>/edit/',views.EditActivityType.as_view(),name='add_activity_type'),
    path('classroom/',views.classroom,name='classroom'),
    path('start_classroom/<str:roomid>/',views.start_classroom,name='start_classroom'),
    # path('start_classroom/<str:session_room_id>/',views.start_classroom,name='start_classroom'),
    path('add_subtopic/<int:topicid>/',views.SubTopic.as_view(),name='subtopic'),
    path('add_subtopic/',views.SubTopic.as_view(),name='add_subtopic'),
    path('upcoming_session/',views.UpcomingSession.as_view(),name='upcoming_session'),
    path('all_video/',views.AllVideo.as_view(),name='all_video'),
    path('all_video/<int:pk>/edit/',views.EditVideo.as_view(),name='all_video'),
    path('all_video/<int:pk>/delete/',views.DeleteVideo.as_view(),name='delete_video'),
    
    path('add_video/<int:topicid>/',views.AddVideo.as_view(),name='add_video'),
    path('add_video/',views.AddVideo.as_view(),name='add_video'),
    path('madd_video/',views.maddvideo,name='madd_video'),
    path('test_classroom/',views.test_classroom,name='test_classroom'),
    path('add_role/',views.add_role,name='add_role'),
    path('course_report/',views.course_report,name='course_report'),
    path('get_enrolled_user_list/',views.get_enrolled_user_list,name='get_enrolled_user_list'),
    #path('categories',views.CategoriesView.as_view(),name='categories'),
    #path('allcategories/',views.CategoriesListView.as_view(),name='all_categories'),
    ##re_path(r'^(?P<categoryid>[0-9]+)$',views.DeleteCategory.as_view(),name='delete_category'),
    #path('delete_category/',views.DeleteCategory.as_view(),name='delete_category'),
    #path('delete_category/<int:pk>/',views.DeleteCategory.as_view(),name='delete_category'),
    #path('update_category/',views.UpdateCategory.as_view(),name='update_category'),
    #path('update_category/<int:pk>/',views.UpdateCategory.as_view(),name='update_category'),
    #path('categories/<int:category_father>/',views.CategoriesView.as_view(),name='subcategories'),
    path('delete_activity/',views.delete_activity,name='delete_activity'),
    path('edit_spin_activity/',views.edit_spin_activity,name='edit_spin_activity'),
    path('edit_spin_activity/<int:pk>/',views.edit_spin_activity,name='edit_spin_activity'),
    path('delete_activity/<int:pk>/delete/',views.delete_activity,name='delete_activity'),
    path('spin_activity/',views.SpinActivities.as_view(),name='spin_activity'),
    path('all_questions/',views.AllQuestion.as_view(),name='all_questions'),
    path('spin_activity/<int:id>/',views.SpinActivities.as_view(),name='spin_activity'),
    
    path('spin_activity_topic/<int:topicid>/',views.SpinActivities.as_view(),name='spin_activity_topic'),
    path('spin_activity_topic/',views.SpinActivities.as_view(),name='spin_activity_topic'),
    
    path('all_organization/',views.AllOrganization.as_view(),name='all_organization'),
    path('all_organization_clg/',views.AllOrganizationCollege,name='all_organization_clg'),
    path('organization_courses/<int:orgid>/',views.AllCourse.as_view(),name='organization_courses'),
    path('course_allot/<int:courseid>/',views.course_allot,name='course_allot'),
    path('store_ans_spin/',views.store_answer_for_spinactivity,name='store_ans_spin'),
    path('check_spin_result/',views.check_spin_result,name='check_spin_result'),
    path('add_course_user/',views.CreateCourseForEndUser.as_view(),name='add_course_user'),
    path('all_course_user/',views.AllCourseForEndUser.as_view(),name='all_course_user'),
    path('all_course_clg_user/',views.AllCourseForClgEndUser,name='all_course_clg_user'),
    
    path('all_course_user/<int:pk>/edit/',views.EditCourseForEndUser.as_view(),name='edit_course_user'),
    path('all_course_user/<int:pk>/view/',views.CourseViewForEnduser.as_view(),name='view_course_user'),
    path('all_course_user/<int:pk>/delete/',views.DeleteCourseForEndUser.as_view(),name='delete_course_user'),
    path('all_category_user/',views.AllCategoryForEndUser.as_view(),name='all_category_user'),
    path('all_category_user/<int:pk>/edit/',views.EditCategoryForEndUser.as_view(),name='edit_category_user'),
    path('all_category_user/<int:pk>/delete/',views.DeleteCategoryForEndUser.as_view(),name='delete_category_user'),
    path('add_category_user/',views.CreateCategoryForEndUser.as_view(),name='add_category_user'),
   
    path('analytics/',views.analytics,name='analytics'),
    path('assignment/',views.all_assignment,name='assignment'),
    path('add_assignment/',views.assignment,name="add_assignment"),
    path('add_assignment/<int:pk>/',views.assignment,name="add_assignment"),
    path('edit_assignment/<int:pk>/',views.edit_assignment,name="edit_assignment"),
    path('add_drag/',views.drag,name="add_drag"),
    path('add_drag/<int:pk>/',views.drag,name="add_drag"),
    path('add_drag_element/',views.drag_element,name='add_drag_element'),
    path('add_drag_element/<int:pk>/',views.drag_element,name='add_drag_element'),
    path('assign_course/',views.assign_course,name='assign_course'),
  
    path('country/', views.CountryListView.as_view(), name='country'),
    path('country/add/', views.CountryCreate.as_view(), name='country_create'),
    path('country/edit/<int:pk>', views.CountryUpdate.as_view(), name='country_edit'),
    path('country/delete/<int:pk>', views.CountryDelete.as_view(), name='country_delete'),
    path('state/', views.StateListView.as_view(), name='state'),
    path('state/add/', views.StateCreate.as_view(), name='state_create'),
    path('state/edit/<int:pk>', views.StateUpdate.as_view(), name='state_edit'),
    path('state/delete/<int:pk>', views.StateDelete.as_view(), name='state_delete'),
    path('city/', views.CityListView.as_view(), name='city'),
    path('city/add', views.CityCreate.as_view(), name='city_create'),
    path('city/edit/<int:pk>', views.CityUpdate.as_view(), name='city_edit'),
    path('city/delete/<int:pk>', views.CityDelete.as_view(), name='city_delete'),
    path('get_all_organization',views.all_org_ajax,name='get_all_organization'),
    path('students/',views.AllStudents.as_view(),name='students'),
    path('students_clg/',views.AllStudents_clg,name='students_clg'),
    path('students/edit/<int:pk>/',views.EditStudents.as_view(),name='edit_students'),
    path('students_clg/edit/<int:pk>/',views.EditStudents_clg.as_view(),name='edit_students_clg'),
    path('students/delete/<int:pk>/',views.DeleteStudents.as_view(),name='delete_students'),
    path('add_student_to_course/',views.add_student_to_course,name='add_student_to_course'),
    path('calendar/',views.calendar,name='calendar'),
    path('outlook_sign_in/',views.outlook_sign_in,name='outlook_sign_in'),
    path('callback/',views.callback,name='callback'),
    path('g_a_co_o_org/',views.get_all_courses_of_org,name='g_a_co_o_org'),
    path('assign_permission_and_role/',views.assign_permission_and_role,name='assign_permission_and_role'),
]