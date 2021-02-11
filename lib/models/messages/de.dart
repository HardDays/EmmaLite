// ignore: avoid_classes_with_only_static_members
abstract class DeMessages {
  static Map<String, String> get messages => {
        'measurementsTitleLabel': 'Messungen',
        'prescriptionsTitleLabel': 'Verordnung',
        'mainSettingsTitle': 'Einstellungen',
        'titleAddMeasurementsView': 'Messung hinzufügen',
        'titleCloseButton': 'Schließen',
        'titleCreatePrescriptionsView': 'Neue Verordnung',
        'profileViewLabel': 'Profil',
        'addMenuMeasurementsLabel': 'Messung hinzufügen ',
        'addMenuReportLabel': 'Bericht erstellen ',
        'mainDoctorListTitle': 'Meine Ärzte',
        'themeCellTitle': 'Erscheinungsbild',
        'darkThemeCellTitle': 'Dunkel',
        'brightThemeCellTitle': 'Hell',
        'titleSettingLanguage': 'Sprache',
        'titleAboutApp': 'Über diese App',
        'titleFeedback': 'Feedback',
        'subscriptionConditions': 'Nutzungsbedienungen',
        'subscriptionConfidentiality': 'Sicherheit',
        'titleTodayText': 'Heute',
        'Temperature': 'Körpertemperatur',
        'BloodPressure': 'Blutdruck',
        'BloodPressureUnit': 'mmHG ',
        'HeartRate': 'Puls',
        'HeartRateUnit': 'SPM',
        'titleAddingPulseViewco': 'Puls hinzufügen',
        'titleAddingPulseDateco': 'Datum und Zeit der Messung',
        'minLabelTextco': 'Min. -',
        'maxLabelTextco': 'Max. -',
        'titleAddingPressureViewco': 'Blutdruck hinzufügen',
        'systolicHintco': 'systolisch',
        'diastolicHintco': 'diastolisch',
        'selectSectionPescriptionTitle_3': 'Verlauf',
        'ThereWereNoReceptionsText': 'Keine Einträge vorhanden',
        'actualTextLabel': 'Anstehende Ereignisse',
        'ArchiveTextLabel': 'Verlauf',
        'differenceBackTextLabel': 'spät',
        'differenceThroughTextLabel': 'in',
        'daysText_1': 'Tag',
        'daysText_2': 'Tage',
        'daysText_3': 'Tage',
        'hoursText_1': 'Std.',
        'hoursText_2': 'Std.',
        'hoursText_3': 'Std.',
        'minutesText_1': 'Min.',
        'minutesText_2': 'Min.',
        'minutesText_3': 'Min.',
        'minText': 'Min.',
        'receptionsStayed_1': 'noch',
        'receptionsStayed_2': 'noch',
        'receptionsReception_1': 'Einnahme',
        'receptionsReception_2': 'Einnahmen',
        'receptionsReception_3': 'Einnahmen',
        'prscr_cancelled': 'Abgebrochen',
        'stopExecutionLabel': 'Abbrechen',
        'titlePrescriptionСard': 'Details',
        'removeExecutionLabel': 'Löschen',
        'prscrNameText': 'Name',
        'dosageNameText': 'Dosierung',
        'unitDosageText': 'Einheit',
        'PrescriptionValueTypeDosage_1': 'St.',
        'PrescriptionValueTypeDosage_2': 'ml.',
        'PrescriptionValueTypeDosage_3': 'g.',
        'PrescriptionValueTypeDosage_4': 'mg.',
        'doctorNameText': 'Name des Arztes',
        'frequencyText': 'Häufigkeit',
        'periodicityText': 'Einnahme Hinweis',
        'PrescriptionValueTypePeriodicity_1': 'täglich',
        'PrescriptionValueTypePeriodicity_2': 'jeden zweiten Tag',
        'PrescriptionValueTypePeriodicity_3': 'einmal wöchentlich',
        'PrescriptionValueTypeFrequency_1': 'einmal täglich',
        'PrescriptionValueTypeFrequency_2': 'zweimal täglich',
        'PrescriptionValueTypeFrequency_3': 'dreimal täglich',
        'PrescriptionValueTypeFrequency_4': 'viermal täglich',
        'PrescriptionValueTypeFrequency_5': 'fünfmal täglich',
        'PrescriptionValueTypeFrequency_6': 'sechsmal täglich',
        'amountTextTitle': 'Quantität',
        'medicationType': 'Art der Verordnung',
        'dateText': 'Datum',
        'timeText': 'Zeit',
        'startDateText': 'Start',
        'endDateText': 'Ende',
        'sendButtonText': 'Senden',
        'recipientsMail': 'E-Mail-Adresse des Empfängers',
        'saveButtonText': 'Speichern',
        'titleFirstName': 'Vorname',
        'titleLastName': 'Name',
        'maleButtonTitle': 'männlich',
        'femaleButtonTitle': 'weiblich',
        'birthdayTitle': 'Geburtsdatum',
        'growthTitle': 'Körpergröße',
        'weightTitle': 'Gewicht',
        'mainTitleMeasurements': 'Messungen',
        'addImageButton': 'Bild hinzufügen',
        'createCopyButton': 'Kopie erstellen',
        'medicinePrescriptionType': 'Medikamente',
        'lifeStylePrescriptionType': 'Lifestyle',
        'measurementPrescriptionType': 'Messung',
        'analysisPrescriptionType': 'Analyse',
        'noMyDoctorsListSubTitle':
            'Hier können Sie die Kontaktdaten Ihrer Ärzte hinterlassen',
        'addNewDoctorButtonLabel': 'Arzt hinzufügen',
        'titleAddNewDoctor': 'Neuer Arzt',
        'titleEmail': 'E-Mail-Adresse',
        'titleComment': 'Kommentar (freiwillige Angabe)',
        'addNewMeasurementLabel': 'Messung hinzufügen',
        'noPrescriptionsSubTitle': 'Hier werden Ihre Verordnungen angezeigt',
        'addNewPrescriptionLabel': 'Verordnung hinzufügen',
        'noPrescriptionsPlanTodayTitle': 'Für heute geplante Verordnungen',
        'noPrescriptionsPlanTitle':
            'Für den #DATE# haben Sie keine Verordnungen geplant',
        'noPrescriptionsPlanTodayIntakesTitle': 'Glückwunsch, alles erledigt!',
        'noPrescriptionsPlanIntakesTitle':
            'Glückwunsch, am #DATE# haben Sie alles erledigt!',
        'noPrescriptionsPlanTodayNoIntakesTitle':
            'Heute haben Sie noch nichts erledigt',
        'noPrescriptionsPlanNoIntakesTitle':
            'Am #DATE# haben Sie noch nichts erledigt',
        'titlePerformedPrescriptions': 'Sie haben #COUNT# von #SUM#',
        'titleMorningLabel': 'Hallo',
        'titleSunLabel': 'Hallo',
        'titleEvenLabel': 'Hallo',
        'titleNightLabel': 'Hallo',
        'titleNearestPrescriptions': 'Ihre Verordnungen',
        'titleInfoProgressPrescriptions':
            'Hier werden Ihre Fortschritte angezeigt',
        'addPrescriptionToday': ' Verordnung hinzufügen',
        'titleSettingsAddPassword': 'Anmelden',
        'titleUsePassword': 'Passwort nutzen',
        'titleCancelButton': 'Abbrechen',
        'titleChangePassword': 'Passwort ändern',
        'titleInputPassword_0': 'Passwort:',
        'WrongPasswordTitle': 'Falsches Passwort',
        'PasswordsDoNotMatchTitle': 'Passwörter stimmen nicht überein',
        'titleUseBiometricFaceID': 'Face ID nutzen',
        'titleUseBiometricTouchID': 'Touch ID nutzen',
        'subTitleUseBiometric':
            'Dadurch können Sie ohne Passwortangabe die App nutzen',
        'buttonUseTextFaceID': 'Ja, Face ID nutzen',
        'buttonUseTextTouchID': 'Ja, Touch ID nutzen',
        'getAcquaintedTitle': 'Willkommen!',
        'fillOutYourProfileTitle':
            'Erstellen Sie ein Profil, um Ihre Vitaldaten an Ihren Arzt zu senden',
        'fillOutYourProfileButtonTitle': 'Profil erstellen',
        'doItLaterButtonTitle': 'Später',
        'secureYourDataTitle': 'Datenschutz',
        'createPasswordButtonTitle': 'Passwort erstellen',
        'laterButtonText': 'Später ',
        'addingTemperatureTitle': 'Körpertemperatur hinzufügen',
        'temperatureFieldTitle': 'Körpertemperatur, °C',
        'reportSubject': 'Bericht EMMA Lite',
        'reportReportString': 'Bericht',
        'reportDescription':
            'Über Versorgungs- und Behandlungsmaßnahmen im Zeitraum',
        'reportComment': 'Kommentar',
        '056789111213141516171819old': 'Jahre',
        '1old': 'Jahr',
        '234old': 'Jahre',
        'addingWeightTitle': 'Gewicht hinzufügen',
        'WeightUnit': 'kg',
        'addingBloodSugarTitle': 'Blutzuckerwert hinzufügen',
        'BloodSugar': 'Blutzuckerwert',
        'BloodSugarUnit': 'mmol/l',
        'mealDate': 'Mahlzeit',
        'optionalString': 'optional',
        'activateAppleHealthSubTitle':
            'Aktivieren Sie Apple Health, um Gesundheitsdaten zu importieren und zu exportieren, damit Sie mehr Informationen über Ihren Gesundheitsstatus erhalten.',
        'activateAppleHealthButtonTitle': 'Aktivieren',
        'doneAppleHealthButtonTitle': 'Erledigt!',
        'activateHintAppleHealthSubTitle':
            'Im nächsten Schritt werden Sie gebeten, Ihre Datenzugriffseinstellungen für die jeweiligen Gesundheitskategorien auszuwählen.',
        'furtherButtonTitle': 'Weiter',
        'HideScreenButtonTitle': 'Ausblenden',
        'consentToTheProcessingOfPersonalDataMainLabelTitle':
            'Durch das Erstellen eines Familienprofils für Personen aus Ihrem Familien-, Freundes- und Bekanntenkreis bestätigen Sie, ihre Einwilligung zur Verarbeitung personenbezogener Daten erhalten zu haben.',
        'confirmMyConsentButtonTitle': 'Akzeptieren',
        'createNewProfileNavBarTitle': 'Profil hinzufügen',
        'profileManagementNavBarTitle': 'Profile',
        'deleteProfileViewMainTitleText':
            'Sind Sie sicher, dass Sie Ihr Profil löschen wollen?',
        'pressPlusButtonHintForCreateNewProfileSubmitButtonTitle': 'Ok'
      };
}