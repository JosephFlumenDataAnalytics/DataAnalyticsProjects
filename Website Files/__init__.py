from flask import Flask

def create_app():
    app = Flask(__name__,template_folder='../templates')
    app.jinja_env.auto_reload = True
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    from .routes .flumen_site import flumen_bp
    app.register_blueprint(flumen_bp, url_prefix='/')

    from .routes .analytics import analytics_bp
    app.register_blueprint(analytics_bp, url_prefix='/analytics')

    return app