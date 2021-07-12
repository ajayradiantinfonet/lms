"""
WSGI config for LMS project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
import sys

#sys.path.append("/var/www/html/lms/LMS/")
#sys.path.append("/var/www/html/lms/LMS/uploads/")
#sys.path.append("/var/www/html/lms/LMS/templates")

#import os

#from django.core.wsgi import get_wsgi_application
#import sys

sys.path.append("/var/www/html/lms/LMS/")
sys.path.append("/var/www/html/lms/LMS/uploads/")
sys.path.append("/var/www/html/lms/LMS/templates")

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'LMS.settings')
sys.path.insert(0,"/var/www/html/lms/env/lib/python3.8/site-packages")

os.environ['HTTPS'] = "on"
application = get_wsgi_application()
