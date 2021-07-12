# Specifically written by zubair 
# property of talento consulting 
#not used till now - > inspired by some LMS repo


class Error(Exception):
    """
    Basic learning package exception
    """



class ResourceNotReusableError(Error):
    """
    The resource cannot be reused by anyone
    """


class ResourceAlreadyOnActivityError(Error):
    """
    The resource is already linked with an activity
    """


class ResourceNotReusableOnlyAuthorError(Error):
    """
    The resource is not reusable, except for its author
    """


class ResourceIsNotLinkedWithThisActivityError(Error):
    """
    The resource is not linked with the activity
    """




class ActivityNotReusableOnlyAuthorError(Error):
    """
    The activity cannot be reused by anyone
    """


class ActivityAlreadyOnCourseError(Error):
    """
    The activity is already linked with a course
    """


class ActivityNotReusableError(Error):
    """
    The activity is not reusable
    """


class ActivityIsNotLinkedWithThisCourseError(Error):
    """
    The activity is not linked with the course
    """



class CannotRegisterOnCourseError(Error):
    """
    It is not possible to register on a course
    """


class RegistrationDisabledError(Error):
    """
    Registration is disabled on a course
    """


class CannotAddCollaboratorOnCourseError(Error):
    """
    It is not possible to add a collaborator on a course
    """


class ChangeActivityOnCourseError(Error):
    """
    It is not possible to change the activity on a course
    """


class UserIsAlreadyCollaborator(Error):
    """
    The user is already a collaborator on the course
    """


class UserIsAlreadyAuthor(Error):
    """
    The user is already author on the course
    """


class UserNotCollaboratorError(Error):
    """
    The user is not a collaborator on the course
    """


class UserIsNotStudent(Error):
    """
    The user is not a student on the course
    """


class UserIsAlreadyStudent(Error):
    """
    The user is already a student on the course
    """



class ObjectiveAlreadyInModel(Error):
    """
    The competence is already in the model
    """


class ObjectiveNotInModel(Error):
    """
    The competence is not in the model
    """


class ObjectiveAlreadyExists(Error):
    """
    The course_objective exists
    """


class ObjectiveAbilityCannotBeEmpty(Error):
    """
    The ability cannot be empty
    """


class ObjectiveIsAlreadyValidated(Error):
    """
    The course_objective is already validated
    """


class ObjectiveIsNotValidated(Error):
    """
    The course_objective is not validated
    """
