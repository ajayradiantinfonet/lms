from django.urls import path
from . import views


urlpatterns = [
	path('register/', views.registerPage,name="register"),
	path('login/', views.loginPage, name="login"),  
	path('logout/', views.logoutUser, name="logout"),
    path('signup/',views.registerPage,name='signup'),
    path('permission_failure/',views.permission_failure,name='permission_failure'),
    path('account_activate/<str:token>/',views.account_activate,name='account_activate'),
    path('account_verify',views.account_verify,name='account_verify'),
    path('check_email',views.check_email,name='check_email'),
    # path('', views.home, name="home"),
    # path('user/', views.userPage, name="user-page"),
    # path('products/', views.products, name='products'),
    # path('customer/<str:pk_test>/', views.customer, name="customer"),
    # path('create_order/<str:pk>/', views.createOrder, name="create_order"),
    # path('update_order/<str:pk>/', views.updateOrder, name="update_order"),
    # path('delete_order/<str:pk>/', views.deleteOrder, name="delete_order"),
]