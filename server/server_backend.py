from uuid import uuid4
import random


class UserServer:
    def __init__(self):
        pass

    def register(self, first_name, last_name, username, password):
        user_id = str(uuid4())
        return {"uid": user_id}

    def get_info(self, user_id=None, username=None):
        # TODO: user_id
        first_name = random.choice(["Peter", "Nikolas", "Andel"])
        last_name = random.choice(["Jekirson", "Dales", "Stathem"])
        username = random.choice(["flooddeath", "manchesterbesiege", "spinglyyard"])
        return {"uid": user_id, "first_name": first_name, "last_name": last_name, "username": username}

    def start_disease_history(self, user_id, disease):
        pass

    def get_disease_info(self, user_id, disease):
        pass

    def end_disease_history(self, user_id, disease):
        pass

    def get_diseases(self, user_id):
        pass

    def add_treatment_step(self, user_id, disease_id, step):
        pass

    def confirm_treatment_step(self, user_id, disease_id, stepid):
        pass

    def get_treatment_steps(self, disease_id):
        pass

    def add_user_state(self, user_id, state):
        pass

    def get_user_state_history(self, user_id):
        pass


class GrugServer:
    def __init__(self):
        pass

    def register(self):
        pass

    def get_info(self, id):
        pass
