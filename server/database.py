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
        "name": "Genicin",
        "description": "Glucosamine is sugar protein that helps your body build cartilage (the hard connective tissue located mainly on the bones near your joints).
        
        Glucosamine is a naturally occurring substance found in bones, bone marrow, shellfish and fungus.
        
        Glucosamine has been used in alternative medicine as an aid to relieving joint pain, swelling, and stiffness caused by arthritis.
        
        Not all uses for glucosamine have been approved by the FDA. Glucosamine should not be used in place of medication prescribed for you by your doctor.
        
        Glucosamine is often sold as an herbal supplement. There are no regulated manufacturing standards in place for many herbal compounds and some marketed supplements have been found to be contaminated with toxic metals or other drugs. Herbal/health supplements should be purchased from a reliable source to minimize the risk of contamination.
        
        Glucosamine may also be used for purposes not listed in this product guide.",
        "active_ingridient": "glucosamine",
        "contraindications": [2, 3],
        "side_effects": "Get emergency medical help if you have any of these signs of an allergic reaction: hives; difficult breathing; swelling of your face, lips, tongue, or throat.
        Common side effects may include: nausea, vomiting, diarrhea, constipation; or heartburn"
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
