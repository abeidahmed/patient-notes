module PracticeWordsHelper
  def calculate_result(practice_word)
    "#{practice_word.pronounced_count}/#{practice_word.total_pronunciation_attempts} = #{practice_word.success_percentage}%"
  end
end
