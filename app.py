from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'K8s Cluster online!'