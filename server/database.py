PATIENT, DOCTOR, *_ = range(1000)
MEDICINE, ANALYSIS, DOC_VISIT, *_ = range(1000)

users = [
    {
        # disease
        "id": 1,
        "role": PATIENT,
        "first_name": "Leila",
        "last_name": "Smith",
        "username": "leila_s",
        "pic_url": ""
    },
    {
        # disease
        "id": 2,
        "role": PATIENT,
        "first_name": "Oliver",
        "last_name": "Brown",
        "username": "oliver_brown_1976",
        "pic_url": ""
    },
    {
        # health
        "id": 3,
        "role": PATIENT,
        "first_name": "William",
        "last_name": "Brown",
        "username": "oliver_brown_1976",
        "pic_url": ""
    },
    {
        "id": 4,
        "role": DOCTOR,
        "first_name": "James",
        "last_name": "Williams",
        "username": "j_williams",
        "pic_url": ""
    },
]

diagnosis = [
    {
        "id": 1,
        "start_date": "2018-09-10 18:00:00",  # YYYY-MM-DD HH:MM:SS in UTC
        "end_date": "",
        "description": "asthma",
        "patient_id": 1,
        "doctor_id": 1
    },
    {
        "id": 2,
        "start_date": "2018-10-16 13:00:00",  # YYYY-MM-DD HH:MM:SS in UTC
        "end_date": "",
        "description": "Influenza",
        "patient_id": 2,
        "doctor_id": 2
    }
]

treatments = [
    {
        "id": 1,
        "start_date": "2018-09-10 18:00:00",
        "end_date": "",
        "doctor_id": 1,
        "diagnosis_id": 1
    },
    {
        "id": 2,
        "start_date": "2018-10-16 13:00:00",
        "end_date": "",
        "doctor_id": 2,
        "diagnosis_id": 2
    },
]

events = [
    {
        "id": 1,
        "treatment_id": 1,
        "doctor_id": 1,
        "event_type": ANALYSIS,
        "drug_id": "",
        "analysis": "photofluorography",
        "date": "",
    },
    {
        "id": 2,
        "treatment_id": 1,
        "doctor_id": 1,
        "event_type": MEDICINE,
        "drug_id": 1,
        "analysis": "",
        "date": "",
    },
    {
        "id": 3,
        "treatment_id": 2,
        "doctor_id": 2,
        "event_type": ANALYSIS,
        "drug_id": 1,
        "analysis": "blood",
        "date": "",
    },
    {
        "id": 4,
        "treatment_id": 2,
        "doctor_id": 2,
        "event_type": MEDICINE,
        "drug_id": 3,
        "analysis": "",
        "date": "",
    },
]



# user_event = {
#     "name"
#     "t_start"
#     "t_end"
#     "desc"
#     "palce"
# }
#
# user_login = {
#     "username"
#     "password"
# } -> token: uuid
#
#
