class PerformanceAnalyzerService 
    def initialize(user)
        @user = user 
    end

    def analyze 
        metrics = @user.calculate_performance_metrics 

        suggestions = []

        if metrics[:attendance_rate] < 90 
            suggestions << "Votre presence au boulot tombe à moins de 90%, Veuillez améliorer votre présence au travail"
        end 

        # if metrics[:average_daily_hours] < 7.5
        #     suggestions << "Votre moyenne journalière par jour va en dessous de 7.5 heure; essayez de plus vous concentrer à l'amélioration des vos heures de travail"
        # end

        if metrics[:attendance_rate] > 98 && metrics[:average_daily_hours] > 8 
            suggestions << "Courage !! C'est du bon boulot! Pour encore plus ameliorer vous pouvez aussi essayer d'ameliorer la qualité de vos rapports"
        end

        {
            metrics: metrics,
            suggestions: suggestions
        }
    end
end
