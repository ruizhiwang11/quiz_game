from faker import Faker
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import time


def inject_data(data, db):

    # function to calculate inject data
    start_time = time.time()

    for d in data:
        doc_ref = db.collection("fake-users_2").document()
        doc_ref.set(d)

    end_time = time.time()

    return end_time - start_time


def main_test():
    
    # initialize firebase db instance

    cred = credentials.Certificate("./quizgame-cred.json")
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    # create fake data, each fake data batch is 1000 data
    fake = Faker()
    data = [{
    "name": fake.name(),
    "email": fake.email(),
    "age": fake.random_int(min=18, max=80),
    "address": fake.address()
    } for i in range(30)]

    # running thhe test for 10 times to calculate the exact performance metric for injecting data

    times = []
    for i in range(10):
        t = inject_data(data, db)
        times.append(t)
        print(f"Run {i+1}: {t:.2f} seconds")

    avg_time = sum(times) / len(times)
    print(f"Average time: {avg_time:.2f} seconds")

if __name__ == '__main__':
    main_test()







