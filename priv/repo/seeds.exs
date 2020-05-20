# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Survey.Repo.insert!(%Survey.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Survey.Questionnaire.{Quiz, Question, Choice, Answer}
alias Survey.Accounts.User
alias Survey.Repo

for schema <- [Answer, Choice, Question, Quiz, User] do
  Repo.delete_all schema
end

Repo.insert! %User{
  name: "Bob"
}

# Quiz 1 ########################################################3

quiz1 = Repo.insert! %Quiz{
  title: "Quiz #1",
  description: "The first quiz",
  image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/800px-Flag_of_the_United_States.svg.png"
}

question = Repo.insert! %Question{
  text: "Choose your favorite color from this list.",
  quiz: quiz1
}

Enum.each(["Green", "Red", "Blue", "Purple"], fn color ->
  Repo.insert! %Choice{
    text: color,
    question: question
  }
end)

question = Repo.insert! %Question{
  text: "Choose your favorite music genre from this list.",
  quiz: quiz1
}

Enum.each(["Jazz", "Rock", "Alternative", "Classic"], fn genre ->
  Repo.insert! %Choice{
    text: genre,
    question: question
  }
end)

# Quiz 2 ########################################################3

quiz2 = Repo.insert! %Quiz{
  title: "Quiz #2",
  description: "The second quiz",
  image_url: "https://upload.wikimedia.org/wikipedia/en/a/ae/Flag_of_the_United_Kingdom.svg"
}

question = Repo.insert! %Question{
  text: "Choose your favorite season.",
  quiz: quiz2
}

Enum.each(["Spring", "Summer", "Fall", "Winter"], fn season ->
  Repo.insert! %Choice{
    text: season,
    question: question
  }
end)

question = Repo.insert! %Question{
  text: "Choose your favorite care make from this list.",
  quiz: quiz2
}

Enum.each(["Honda", "Toyota", "Nissan", "Ford"], fn make ->
  Repo.insert! %Choice{
    text: make,
    question: question
  }
end)
