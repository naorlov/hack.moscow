PATIENT, DOCTOR, _ = range(1000)
MEDICINE, ANALYSIS, DOC_VISIT, _ = range(1000)

users = [
    {
        "id": 1,
        "role": PATIENT,
        "first_name": "Leila",
        "last_name": "Smith",
        "username": "leila_s",
        "pic_url": ""
    },
]

drugs = [
    {
        "id": 1,
        "name": "",
        "description": "",
        "substance": "",
        "contraindications": "",
        "side_effects": "",
        "pic_url": ""
    }
]

diagnosis = [
    {
        "id": 1,
        "start_date": "",
        "end_date": "",
        "description": "",
        "patient_id": "",
        "doctor_id": ""
    }
]

treatments = [
    {
        "id": 1,
        "start_date": "",
        "end_date": "",
        "doctor_id": "",
        "diagnosis_id": ""
    }
]

events = [
    {
        "id": 1,
        "event_type": "",
        "treatment_id": "",
        "drug_id": "",
        "date": "",
    }
]
