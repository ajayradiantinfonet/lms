# from channels.routing import route
# from example.cons import ws_connect, ws_disconnect


# channel_routing = [
#     route('websocket.connect', ws_connect),
#     route('websocket.disconnect', ws_disconnect),
# ]



from channels.routing import ProtocolTypeRouter , URLRouter
from channels.auth import AuthMiddlewareStack
from django.urls import include
from chat.routing import websocket_urlpatterns

application = ProtocolTypeRouter({
    # Empty for now (http->django views is added by default)
     'websocket': AuthMiddlewareStack(
        URLRouter(
            websocket_urlpatterns
        )
    ),
})
