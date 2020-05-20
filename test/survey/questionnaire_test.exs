defmodule Survey.QuestionnaireTest do
  use Survey.DataCase

  alias Survey.Questionnaire

  describe "quizzes" do
    alias Survey.Questionnaire.Quiz

    @valid_attrs %{
      description: "some description",
      image_url: "some image_url",
      title: "some title"
    }
    @update_attrs %{
      description: "some updated description",
      image_url: "some updated image_url",
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, image_url: nil, title: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questionnaire.create_quiz()

      quiz
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert Questionnaire.list_quizzes() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Questionnaire.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = Questionnaire.create_quiz(@valid_attrs)
      assert quiz.description == "some description"
      assert quiz.image_url == "some image_url"
      assert quiz.title == "some title"
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questionnaire.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = Questionnaire.update_quiz(quiz, @update_attrs)
      assert quiz.description == "some updated description"
      assert quiz.image_url == "some updated image_url"
      assert quiz.title == "some updated title"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = Questionnaire.update_quiz(quiz, @invalid_attrs)
      assert quiz == Questionnaire.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Questionnaire.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Questionnaire.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Questionnaire.change_quiz(quiz)
    end
  end

  describe "questions" do
    alias Survey.Questionnaire.Question

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questionnaire.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questionnaire.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questionnaire.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Questionnaire.create_question(@valid_attrs)
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questionnaire.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()

      assert {:ok, %Question{} = question} =
               Questionnaire.update_question(question, @update_attrs)

      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questionnaire.update_question(question, @invalid_attrs)
      assert question == Questionnaire.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questionnaire.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questionnaire.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questionnaire.change_question(question)
    end
  end

  describe "choices" do
    alias Survey.Questionnaire.Choice

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def choice_fixture(attrs \\ %{}) do
      {:ok, choice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questionnaire.create_choice()

      choice
    end

    test "list_choices/0 returns all choices" do
      choice = choice_fixture()
      assert Questionnaire.list_choices() == [choice]
    end

    test "get_choice!/1 returns the choice with given id" do
      choice = choice_fixture()
      assert Questionnaire.get_choice!(choice.id) == choice
    end

    test "create_choice/1 with valid data creates a choice" do
      assert {:ok, %Choice{} = choice} = Questionnaire.create_choice(@valid_attrs)
      assert choice.text == "some text"
    end

    test "create_choice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questionnaire.create_choice(@invalid_attrs)
    end

    test "update_choice/2 with valid data updates the choice" do
      choice = choice_fixture()
      assert {:ok, %Choice{} = choice} = Questionnaire.update_choice(choice, @update_attrs)
      assert choice.text == "some updated text"
    end

    test "update_choice/2 with invalid data returns error changeset" do
      choice = choice_fixture()
      assert {:error, %Ecto.Changeset{}} = Questionnaire.update_choice(choice, @invalid_attrs)
      assert choice == Questionnaire.get_choice!(choice.id)
    end

    test "delete_choice/1 deletes the choice" do
      choice = choice_fixture()
      assert {:ok, %Choice{}} = Questionnaire.delete_choice(choice)
      assert_raise Ecto.NoResultsError, fn -> Questionnaire.get_choice!(choice.id) end
    end

    test "change_choice/1 returns a choice changeset" do
      choice = choice_fixture()
      assert %Ecto.Changeset{} = Questionnaire.change_choice(choice)
    end
  end

  describe "answers" do
    alias Survey.Questionnaire.Answer

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questionnaire.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Questionnaire.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Questionnaire.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Questionnaire.create_answer(@valid_attrs)
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questionnaire.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{} = answer} = Questionnaire.update_answer(answer, @update_attrs)
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Questionnaire.update_answer(answer, @invalid_attrs)
      assert answer == Questionnaire.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Questionnaire.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Questionnaire.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Questionnaire.change_answer(answer)
    end
  end
end
