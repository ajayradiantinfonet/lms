#userlmstag.py
from django import template
from django.conf import settings
register = template.Library()

@register.filter()
def check_permission(user, permission):
	if user.perms.has_perm(permission):
		return True
    #if user.user_permissions.filter(codename = permission).exists():
        #return True
	return False

@register.filter()
def check_group(user, group_name):
    if user.groups.filter(name=group_name).exists():
        return True
    #if user.user_permissions.filter(codename = permission).exists():
        #return True
    return False

from django.contrib.auth.models import User

@register.filter()
def check_student_in_course(user_id,courseid):
    from customadmin.models import CoursesEndUser
    u=User.objects.get(id=user_id)
    c=CoursesEndUser.objects.get(id=courseid)
    # print(c.students)
    if len(c.students.filter(id=u.id)) > 0:
        return True
    # if len(u.coursesenduser_set.filter(coursesenduser=courseid)) > 0:
    #     return True
    return False

@register.filter()
def is_learningunit_open(userid,topicid):
    from customadmin.models import CoursesEndUser,Topic,TopicWiseAnswerpaper
    #u=User.objects.get(id=userid)
    #t=Topic.objects.get(id=topicid)
    from django.db.models import Q
    tw=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),Q(topic_id=topicid),Q(is_open=1),
        Q(activity=None))
    if len(tw) > 0:
        return True
    return False

from organization.models import UserInformation

# @register.filter()
# def get_first_name_by_id(userid):
#     uid=userid
#     u=User.objects.get(id=uid)
#     if not u.is_superuser:
#         return UserInformation.objects.get(user=u).first_name
#     return "root"


@register.filter()
def get_first_name(userid):
    if not userid.is_superuser:
        #this is kaif change
        # return UserInformation.objects.get(user=userid).first_name
        return userid.first_name
    return "root"

@register.filter()
def get_last_name(userid):
    if not userid.is_superuser:
        return UserInformation.objects.get(user=userid).last_name
        
    return "root"

@register.filter()
def get_image_url(userid):
    if not userid.is_superuser:
        return userid.image.url
        # return UserInformation.objects.get(user=userid).image.url
    return userid.image.url


@register.filter()
def divide_tag(value, arg):
    try:
        return  int(value) / arg
    except (ValueError, ZeroDivisionError):
        return None


@register.simple_tag
def settings_value(name):
    return getattr(settings, name, "")




