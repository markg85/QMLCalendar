#ifndef QMONTH_H
#define QMONTH_H

#include <QDeclarativeItem>
#include <QVarLengthArray>
#include <QDate>
#include "qmonthmodel.h"

// Magic number 42! It's not the number of everything: http://en.wikipedia.org/wiki/42_(number)
// It's the number of days to show in a one month calendar view (6 weeks * 7 = 42)
#define NUMBER_OF_DAYS_IN_CAL 42

class QMonth : public QDeclarativeItem, public QDate
{
    Q_OBJECT
    Q_PROPERTY(QString date READ toString("yyyy-M") WRITE recalculate NOTIFY dateChanged)
    Q_PROPERTY(int startOffset READ startOffset WRITE setStartOffset NOTIFY startOffsetChanged)
    Q_PROPERTY(int endOffset READ endOffset WRITE setEndOffset NOTIFY endOffsetChanged)
    Q_PROPERTY(QString monthName READ longMonthName NOTIFY monthNameChanged)
    Q_PROPERTY(int year READ year CONSTANT)
    Q_PROPERTY(int month READ month CONSTANT)
    Q_PROPERTY(int customMonth READ customMonth WRITE setCustomMonth NOTIFY customMonthChanged)
    Q_PROPERTY(int day READ day CONSTANT)
    Q_PROPERTY(int currentDay READ currentDay CONSTANT)
    Q_PROPERTY(int currentMonth READ currentMonth CONSTANT)
    Q_PROPERTY(bool monthFromCurrentDate READ monthFromCurrentDate CONSTANT)
    Q_PROPERTY(QMonthModel* model READ model NOTIFY modelChanged)
public:
    explicit QMonth(QDeclarativeItem *parent = 0);

    void setStartOffset(int offset);
    int startOffset();

    void setEndOffset(int offset);
    int endOffset();

    void recalculate(int iyear, int imonth, int iday = 1);
    void recalculate(const QString& date);

    void setCustomMonth(int imonth);
    int customMonth();

    Q_INVOKABLE void previousMonth(); // convenient function for QML
    Q_INVOKABLE void nextMonth(); // convenient function for QML
    void setLongMonthName(const QString& longMonthName); // convenient function for QML
    QString longMonthName(); // convenient function for QML
    bool monthFromCurrentDate();
    int currentDay(); // Always returns the real current day.
    int currentMonth(); // Always returns the real current month.

    const QVarLengthArray<int, NUMBER_OF_DAYS_IN_CAL>& arrayMonth();
    QMonthModel* model();
    
signals:
    void dateChanged();
    void startOffsetChanged();
    void endOffsetChanged();
    void modelChanged();
    void customMonthChanged();
    void monthNameChanged();
    
public slots:
    

private:
    void calculateMonth();
    int m_startOffset;
    int m_endOffset;
    int m_currentDay;
    int m_currentMonth;
    int m_customMonth;
    bool m_monthFromCurrentDate;
    QVarLengthArray<int, NUMBER_OF_DAYS_IN_CAL> m_month;
    QMonthModel m_model;
    QString m_longMonthName;
};

QML_DECLARE_TYPE(QMonthModel)

#endif // QMONTH_H
