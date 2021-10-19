from import_export import resources
from organization.models import UserInformation

class UserInformationResource(resources.ModelResource):
    class Meta:
        model = UserInformation