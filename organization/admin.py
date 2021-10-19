from import_export.admin import ImportExportModelAdmin
from django.contrib import admin
from .models import UserInformation

@admin.register(UserInformation)
class UserInformationAdmin(ImportExportModelAdmin):
    pass