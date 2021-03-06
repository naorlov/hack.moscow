import os
from random import randint

from flask import Flask
from flask import request
from flask import jsonify

import database
import drugs
from server_backend import UserServer

print("initializing flask")
app = Flask(
    __name__,
    root_path=os.path.abspath('.'),
)

srv = UserServer()
ERROR = -1


def find_user(data, user_id):
    for el in data:
        if el["id"] == user_id:
            return el
    return ERROR


def find_diagnosis_info(data, user_id):
    for el in data:
        if el["patient_id"] == user_id:
            return el
    return ERROR


def find_treatment_info(data, diagnosis_id):
    for el in data:
        if el["diagnosis_id"] == diagnosis_id:
            return el
    return "ERROR"


def find_events(data, treatment_id):
    result = list()
    for el in data:
        if el["treatment_id"] == treatment_id:
            result.append(el)

    if len(result) > 0:
        return result
    else:
        return "ERROR"


@app.route("/users/<int:user_id>/", methods=["GET", "POST"])
def get_user_info(user_id):
    result = {}

    user_info = find_user(database.users, user_id)
    if user_info == ERROR:
        result["user_info"] = "not found"
        result["diagnosis_info"] = "not found"
        result["treatment_info"] = "not found"
        result["events"] = "not found"
        return jsonify(result)
    result["user_info"] = user_info

    diagnosis_info = find_diagnosis_info(database.diagnosis, user_id)
    if diagnosis_info == ERROR:
        result["diagnosis_info"] = "not found"
        result["treatment_info"] = "not found"
        result["events"] = "not found"
        return jsonify(result)
    result["diagnosis_info"] = diagnosis_info

    diagnosis_id = diagnosis_info["id"]
    treatment_info = find_treatment_info(database.treatments, diagnosis_id)
    if treatment_info == ERROR:
        result["treatment_info"] = "not found"
        result["events"] = "not found"
        return jsonify(result)
    result["treatment_info"] = treatment_info

    treatment_id = treatment_info["id"]
    events_info = find_events(database.events, treatment_id)
    if events_info == ERROR:
        result["events"] = "not found"
        return jsonify(result)
    result["events"] = events_info

    return jsonify(result)


@app.route("/drug/<int:drug_id>/")
def get_drug_info(drug_id):
    try:
        return jsonify(drugs.drugs[drug_id])
    except:
        return jsonify({"id": -1})


@app.route("/login", methods=["POST"])
def login_user():
    data = request.get_json()


@app.route("/user_events/week/", methods=["GET"])
def get_week_events(day):
    user_token = request.args["token"]
    username = request.args["username"]
    day = request.args["day"]
    return srv.get_week_events(username, day)

@app.route("/user_events/day/<string:day>", methods=["GET"])
def get_day_events(day):
    user_token = request.args[""]
@app.route("/randarticle/")
def get_random_article():
    numArticles = srv.count_articles()
    randId = randint(1, numArticles)
    article = srv.get_article(randId)
    return jsonify(article)


if __name__ == '__main__':
    app.run(host="127.0.0.1", port="9999")
