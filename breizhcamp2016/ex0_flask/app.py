# encoding: utf-8
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/status')
def status():
    return 'I\'m Flask, up and running!'

@app.route('/', defaults={'name': 'Flask'})
@app.route('/hello/<name>')
def index(name):
    return render_template('hello.html', name=name)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

