#!/bin/python3

if __name__ == '__main__':
    students = []
    scores = []

    for _ in range(int(input())):
        name = input()
        score = float(input())

        students.append([name, score])

        scores.append(score)

    second_max = sorted(list(set(scores)), reverse=True)[-2]
    matches = sorted(
        [name for [name, score] in students if score == second_max])

    for student in matches:
        print(student)
