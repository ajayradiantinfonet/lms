from django.db import models
from django.db.models.deletion import CASCADE

# Create your models here.
#from customadmin.models import City,Country,State
from customadmin.models import  Organization ,City,Country,State
from django.contrib.auth.models import User
from django.conf import settings


#position_choices=(('student','student'),('teacher','teacher'),('collaborator','c'))
class UserInformation(models.Model):
    user=models.OneToOneField(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,related_name='user_info')
    end_user=models.BooleanField(default=True)
    position=models.CharField(max_length=155)
    email=models.EmailField(max_length=255,unique=True)
    #phone=models.IntegerField(default=0)
    phone=models.IntegerField(default=0,unique=True)
    is_active=models.BooleanField(default=False)
    organization=models.ForeignKey(Organization,on_delete=models.CASCADE,
        related_name='organization_user')
    # college = models.ForeignKey(College,on_delete=models.CASCADE)    

    first_name = models.CharField(max_length=150,null=True)
    last_name = models.CharField(max_length=150,null=True)
    houseno = models.CharField(max_length=125,null=True)
    # registration_date = models.CharField(max_length=125,null=True,blank=True)
    address= models.CharField(max_length=225,null=True)
    address1 = models.CharField(max_length=225,null=True)
    pincode = models.CharField(max_length=150,null=True)
    image = models.ImageField(upload_to='user_profile/',null=True)
    # city = models.ForeignKey(City,on_delete=models.CASCADE,null=True)
    # country = models.ForeignKey(Country,on_delete=models.CASCADE,null=True)
    # state = models.ForeignKey(State,on_delete=models.CASCADE,null=True)
    def __str__(self):
    	return self.user.username


    def get_all_teacher(self):
    	return self.get_queryset().filter(position='teacher')

    def get_teacher_of_perticuler_org(self,organization_id):
    	return self.get_queryset().filter(position='teacher',organization_id=organization_id)
