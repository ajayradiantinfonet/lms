from rest_framework import serializers
from preassesment.models import (
    Question, Quiz, QuestionPaper, AnswerPaper
)


class QuestionSerializer(serializers.ModelSerializer):
    test_cases = serializers.SerializerMethodField()

    def get_test_cases(self, obj):
        test_cases = obj.get_test_cases_as_dict()
        return test_cases

    class Meta:
        model = Question
        exclude = ('partial_grading', )


class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quiz
        exclude = ('view_answerpaper', )


class QuestionPaperSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuestionPaper
        fields = '__all__'


class AnswerPaperSerializer(serializers.ModelSerializer):

    questions = QuestionSerializer(many=True)

    class Meta:
        model = AnswerPaper
        fields = '__all__'


