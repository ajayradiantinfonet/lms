#mytag.py
from django import template
from django.conf import settings
register = template.Library()


@register.filter()
def user_enrolled(user, courseid):
    from customadmin.models import CourseEnroll,CoursesEndUser
    try:
        #c=CoursesEndUser.objects.filter(id=courseid)
        if CourseEnroll.objects.filter(user=user,course_id=courseid).exists():
            return True
        return False
    except :
        return None

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
    if len(c.students.filter(id=u.id)) > 0:
        return True
    return False

@register.filter()
def is_learningunit_open(userid,topicid):
    from customadmin.models import CoursesEndUser,Topic,TopicWiseAnswerpaper
    from django.db.models import Q
    tw=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),Q(topic_id=topicid),Q(is_open=1),
        Q(activity=None))
    if len(tw) > 0:
        return True
    return False

@register.filter()
def is_video_open(userid,video):
    from customadmin.models import TopicWiseAnswerpaper
    tw=TopicWiseAnswerpaper.objects.filter(user_id=userid,content_video=video,is_open=1)
    if len(tw) > 0:
        return True
    return False

@register.filter()
def is_activity_open(userid,activityid):
    from customadmin.models import CoursesEndUser,Topic,TopicWiseAnswerpaper
    tw=TopicWiseAnswerpaper.objects.filter(user_id=userid,activity_id=activityid,is_open=1)
    if len(tw) > 0:
        return True
    return False

@register.filter()
def divide_tag(value, arg):
    try:
        return  int(value) / arg
    except (ValueError, ZeroDivisionError):
        return None

@register.filter()
def get_questionpaper_id(quizid):
    from preassesment.models import Quiz,QuestionPaper
    try:
        q=Quiz.objects.get(id=quizid)
        qp=QuestionPaper.objects.get(quiz_id=q.id)
        return qp.id
    except Quiz.DoesNotExist:
        pass



# @register.filter()
# def get_org_of_course(courseid):
#     c=CoursesEndUser.objects.get(id=courseid)


@register.simple_tag
def settings_value(name):
    return getattr(settings, name, "")




