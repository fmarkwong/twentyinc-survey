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
end
