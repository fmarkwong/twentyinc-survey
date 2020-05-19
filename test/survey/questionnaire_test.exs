defmodule Survey.QuestionnaireTest do
  use Survey.DataCase

  alias Survey.Questionnaire

  describe "quizzes" do
    alias Survey.Questionnaire.Quiz

    @valid_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
    @update_attrs %{description: "some updated description", image_url: "some updated image_url", title: "some updated title"}
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
      assert {:ok, %Question{} = question} = Questionnaire.update_question(question, @update_attrs)
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
end
