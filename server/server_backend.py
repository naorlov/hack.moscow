from uuid import uuid4
import os
import pickle
import settings
import pg


def dump_exists(path):
    return os.path.isfile(path) and os.path.isfile(path)


def dbconnect():
    return pg.DB(**settings.db_connection)


class UserServer:
    def __init__(self):
        self.connection = dbconnect()

    def is_username_free(self, username):
        query = f"""SELECT count(*) FROM "users" WHERE "username" = '{username}'"""
        result = self.connection.query(query).getresult()
        return result[0][0] == 0

    def gen_token(self, username):
        token = uuid4()
        query = f"""UPDATE "public"."users" SET "token" = '{token}' WHERE "username" = '{username}'"""
        self.connection.query(query)
        return token

    def get_token(self, username):
        query = f"""SELECT "token" FROM "users" WHERE "username" = '{username}'"""
        return self.connection.query(query).getresult()[0][0]

    def auth_token(self, username, token):
        actual_token = self.get_token(username)
        return actual_token == token

    def authorize(self, username, password):
        query = f"""SELECT "password" FROM users WHERE "username" = '{username}'"""
        password_actual = self.connection.query(query).getresult()[0][0]
        if password_actual == password:
            return self.gen_token(username)
        return {"error": "incorrect_password"}

    def register(self, first_name, last_name, username, password):

        if not self.is_username_free(username):
            return {"error": "username occupied"}

        query = f"""
        INSERT INTO "users" ("username", "password", "role", "first_name", "last_name") \
        VALUES ('{username}', '{password}', 'patient', '{first_name}', '{last_name}')
        """

        self.connection.query(query)

        return self.gen_token(username)

    def get_user(self, username=None, id=None):
        query = f"""SELECT * FROM "public"."users" WHERE "username" = '{username}'"""
        return self.connection.query(query).dictresult()

    def get_user_id(self, username):
        query = f"""SELECT "id" FROM users WHERE "username" = '{username}'"""
        return self.connection.query(query).getresult()[0][0]

    def get_week_events(self, username, date):
        date_end = date + 7 * 24 * 60 * 60
        id = self.get_user_id(username)
        query = f"""SELECT * FROM events WHERE '{date}' < "event_date" AND "event_date" < '{date_end}' AND """


if __name__ == '__main__':
    srv = UserServer()
