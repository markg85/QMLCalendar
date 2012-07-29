#include "qmonth.h"
#include <QDate>
#include <QStandardItem>
#include <QDebug>

/**
  QMonth is a container that calculates which days are in a month
  and puts them in a model list for QML to use along with a tiny
  bit of other information
 */

QMonth::QMonth(QDeclarativeItem *parent) :
    QDeclarativeItem(parent),
    QDate(QDate::currentDate()),
    m_startOffset(0),
    m_endOffset(0),
    m_currentDay(day()),
    m_currentMonth(month()),
    m_customMonth(0),
    m_monthFromCurrentDate(true),
    m_model(),
    m_longMonthName(QDate::longMonthName(month()))
{
    // Calculate the current month.
    calculateMonth();
}

void QMonth::setStartOffset(int offset)
{
    emit startOffsetChanged();
    m_startOffset = offset;
}

int QMonth::startOffset()
{
    return m_startOffset;
}

void QMonth::setEndOffset(int offset)
{
    emit endOffsetChanged();
    m_endOffset = offset;
}

int QMonth::endOffset()
{
    return m_endOffset;
}

void QMonth::recalculate(int iyear, int imonth, int iday)
{
    setDate(iyear, imonth, iday);
    setLongMonthName(QDate::longMonthName(imonth));

    if(QDate(iyear, imonth, m_currentDay) == QDate::currentDate())
    {
        m_monthFromCurrentDate = true;
    }
    else
    {
        m_monthFromCurrentDate = false;
    }

    emit dateChanged();
    calculateMonth();
}

void QMonth::recalculate(const QString &date)
{
    QDate dateFromFormat = QDate::fromString(date, "yyyy-M");
    recalculate(dateFromFormat.year(), dateFromFormat.month(), 1);
}

void QMonth::setCustomMonth(int imonth)
{
    m_customMonth = imonth;
    emit customMonthChanged();

    // Different month thus different month name..
    setLongMonthName(QDate::longMonthName(imonth));
}

int QMonth::customMonth()
{
    return m_customMonth;
}

void QMonth::previousMonth()
{
    int yearCalc = year();
    int monthCalc = month() - 1;

    if(monthCalc < 1)
    {
        yearCalc = year() - 1;
        monthCalc = 12;
    }
    recalculate(yearCalc, monthCalc, 1);
}

void QMonth::nextMonth()
{
    int yearCalc = year();
    int monthCalc = month() + 1;

    if(monthCalc > 12)
    {
        yearCalc = year() + 1;
        monthCalc = 1;
    }
    recalculate(yearCalc, monthCalc, 1);
}

void QMonth::setLongMonthName(const QString &longMonthName)
{
    emit monthNameChanged();
    m_longMonthName = longMonthName;
}

QString QMonth::longMonthName()
{
    return m_longMonthName;
}

bool QMonth::monthFromCurrentDate()
{
    return m_monthFromCurrentDate;
}

int QMonth::currentDay()
{
    return m_currentDay;
}

int QMonth::currentMonth()
{
    return m_currentMonth;
}

const QVarLengthArray<int, NUMBER_OF_DAYS_IN_CAL> &QMonth::arrayMonth()
{
    return m_month;
}

QMonthModel* QMonth::model()
{
    return &m_model;
}

void QMonth::calculateMonth()
{
    // set the month array
    m_month = QVarLengthArray<int, NUMBER_OF_DAYS_IN_CAL>();
    m_model.clear();

    // We need to get the first day since we need to know if the first day is monday or not.
    // And that is required to determine how many days we need to show from the previous month.
    QDate firstDay = QDate(year(), month(), 1);

    // The day - 1 because we need a place for our current day as well.
    setStartOffset(firstDay.dayOfWeek() - 1);

    // A calendar shows 6 weeks. some days before the current month and some days after it.
    // If the month starts with monday then we should start it at the next line otherwise
    // we can't show anything from the last month.
    // In all other cases we simply use the dayOfWeek() as prefix.
    if(firstDay.dayOfWeek() == 1)
    {
        setStartOffset(7);
    }

    int endCalOffset = NUMBER_OF_DAYS_IN_CAL - (startOffset() + daysInMonth());
    setEndOffset(endCalOffset);

    int yearCalc = year();
    int monthCalc = month() - 1;

    // If the current month is januari...
    if(monthCalc < 1)
    {
        monthCalc = 12;
        yearCalc = year() - 1;
    }

    QDate previousMonthDate(yearCalc, monthCalc, 1);
    int dayNumber = 1;

    QList<QStandardItem*> items;

    for(int i = 1; i <= NUMBER_OF_DAYS_IN_CAL; i++)
    {
        bool previousMonth = false;
        bool nextMonth = false;
        bool currentMonth = false;
        if(i <= startOffset())
        {
            dayNumber = previousMonthDate.daysInMonth() - startOffset() + i;
            previousMonth = true;
        }
        else if(i <= daysInMonth() + startOffset())
        {
            currentMonth = true;
            dayNumber = i - startOffset();
        }
        else
        {
            nextMonth = true;
            dayNumber = i - (startOffset() + daysInMonth());
        }

        QStandardItem* item = new QStandardItem();
        m_month.append(i);

        item->setData(QVariant(previousMonth), QMonthModel::PreviousMonth);
        item->setData(QVariant(nextMonth), QMonthModel::NextMonth);
        item->setData(QVariant(currentMonth), QMonthModel::CurrentMonth);
        item->setData(QVariant(dayNumber), QMonthModel::DayNumber);

        items << item;

    }

    m_model.appendColumn(items);

    emit modelChanged();
}


