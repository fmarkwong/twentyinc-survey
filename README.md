# Survey

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Demo

This app is deployed to https://twentyquiz.gigalixirapp.com and can be tested there.

## Design

### Database

Here are tables I created for this app.

`users`
  - name

`quizzes`:  has_many questions
  - title
  - description
  - image_url

`questions`: has_many choices, belongs_to quiz
  - text
  - quiz_id

`choices`: belongs_to question 
  - text
  - question_id

`answers`:  belongs_to user, belongs_to choice 
  - choice_id
  - user_id

### Architecture

The app is called Survey and has two contexts.
  - `Accounts` which just has one `User` schema.
  - `Questionnaire` which consists of the `Quiz`, `Question`, `Choice` and `Answer` schemas

The `Accounts` api is in `lib/survey/accounts.ex`
`Questionnaire` api is in `lib/survey/questionnaire.ex`

The schemas for the contexts are in `lib/survey/accounts` and `lib/survey/questionnaire`

The main controllers are `lib/survey_web/controllers/user_controller.ex` and `lib/survey_web/controllers/quiz_controller.ex`

The controllers take params if any and call the `Accounts` and `Questionnaire` context apis to do the work. 

The main view templates are `lib/survey_web/templates/user` and `quiz`

### Walk through 

The home page is consists of a simple login where you're presented with a list of existing users and click on one to log in or you can create a new user.

After logging in, you're redirected to the quiz listing page. This will list the quizzes the current user has not yet completed. The database is seeded with two quizzes with two questions for each quiz.

The controller action for the quiz listing page is `lib/survey_web/controllers/quiz_controller.ex#index`

`Questionnaire.list_quizzes_for_user/1` calls a query to figure out which quizzes are unfinished for the current user. That query is in `lib/survey/questionair/quiz.ex#not_completed_for/2`. Those quizzes are listed in the quiz listing page.

Once you click on a quiz, you're forwarded to a start page. When you click the start link, you're directed to `quiz_controller.ex#next_question`. This calls the `Question.next_unanswered_question_for/3` query in `lib/survey/questionnaire/question.ex` to grab the next unanswered question for this quiz and user. 

Then you cycle through the two questions and submit answers which are saved to the DB.  Once you get the the last page, you can click to go back to the home quiz listing page and the quiz you just completed will not be there anymore.

Here's some SQL to display all the answers aligned with the question, quiz, and user.

```sql
SELECT
  users.name AS user,
  quizzes.title AS quiz,
  questions.text AS question,
  choices.text AS answer
FROM
  quizzes
JOIN questions ON questions.quiz_id = quizzes.id
JOIN choices ON choices.question_id = questions.id
JOIN answers ON answers.choice_id = choices.id
JOIN users ON answers.user_id = users.id
```
