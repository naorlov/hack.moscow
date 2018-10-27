import os

from flask import Flask
from flask import request
from flask import jsonify

from server_backend import UserServer
import drugs

print("initializing flask")
app = Flask(
    __name__,
    root_path=os.path.abspath('.'),
)

server = UserServer()


@app.route("/users/create", methods=["GET", "POST"])
def create_user():
    first_name, last_name = request.args.get("first_name", "last_name")
    username = request.args.get("username")
    password = request.args.get("password")
    result = server.register(first_name, last_name, username, password)
    return jsonify(result)


@app.route("/users/<user_id>", methods=["GET", "POST"])
def get_user_info(user_id):
    result = server.get_info(user_id)
    return jsonify(result)


@app.route("/drug/<int:drug_id>")
def get_drug_info(drug_id):
    return jsonify(drugs.drugs[drug_id])

if __name__ == '__main__':
    app.run(host="127.0.0.1", port="9999")

