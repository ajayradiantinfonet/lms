#video validators....

def validate_video_extension(value):
    import os
    from django.core.exceptions import ValidationError
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.mp4', '.mp3', '.webm', '.mkv','.avi']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.only supporting these formats ".mp4,.mkv,.webm,.avi"')




#image validators...        