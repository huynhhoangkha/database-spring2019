#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <ctime>
#include <cstdlib>
using namespace std;

#pragma region DATA_DEFINE
enum sex{ MALE = 1, FEMALE = 0};
struct Date { int day, month, year; };

template <class T>
class Nullable {
protected:
    T data;
public:
    virtual bool isNull() = 0;
    virtual operator T() = 0;
    virtual string sqlFormat() = 0;
};

class NullableString: public Nullable<string> {
public:
    NullableString(string _data = string()) { this->data = _data; }
    NullableString operator=(const char* _data) { this->data = string(_data); return *this; }
    bool isNull() { return (data.length() == 0); }
    operator string(){ return this->data; }
    string sqlFormat() {
        if (this->isNull()) return string("NULL");
        else return string("'") + data + string("'");
    }
    friend ostream& operator<<(ostream& out, NullableString& obj);
};

ostream& operator<<(ostream& out, NullableString& obj) {
    out << obj.sqlFormat();
    return out;
}

class NullableDate: public Nullable<Date> {
    bool initialized;
public:
    NullableDate() { this->initialized = false; }
    NullableDate(Date _date) { this->data = _date; this->initialized = true; }
    NullableDate(int _day, int _month, int _year) { 
        this->data.day = _day;
        this->data.month = _month;
        this->data.year = _year;
        this->initialized = true;
    }
    bool isNull() { return !this->initialized; };
    operator Date() { return this->data; };
    string sqlFormat() {
        if (this->isNull()) return string("NULL");
        else {
            string day = to_string(this->data.day);
            while (day.length() < 2) day.insert(day.begin(), '0');
            string month = to_string(this->data.month);
            while (month.length() < 2) month.insert(month.begin(), '0');
            string year = to_string(this->data.year);
            return string("CONVERT(DATE, ")
                    + day + string("-")
                    + month + string("-")
                    + year + string(", 105)");
        }
    }
    friend ostream& operator<<(ostream& out, NullableDate& obj);
};

ostream& operator<<(ostream& out, NullableDate& obj) { out << obj.sqlFormat(); return out; }

class NullableInt: Nullable<int> {
bool initialized;
public:
    NullableInt() { this->initialized = false; }
    NullableInt(int _value) { this->data = _value; this->initialized = true; }
    bool isNull() { return !this->initialized; };
    operator int() { return this->data; }
    operator string() { return to_string(this->data); }
    string sqlFormat() { return this->isNull() ? string("NULL") : to_string(this->data); }
    friend ostream& operator<<(ostream& out, NullableInt& obj);
};

ostream& operator<<(ostream& out, NullableInt& obj) { out << obj.sqlFormat(); return out; }

#pragma endregion DATA_DEFINE

#pragma region RANDOM_FUNCTION
char lowerRand() { return rand() % 26 + 97; }
char upperRand() { return rand() % 26 + 65; }
char digitRand() { return rand() % 10 + 48; }
char alphaNumRand() {
    int flag = rand() % 3;
    return flag == 0 ? lowerRand() : flag == 1 ? upperRand() : digitRand();
}
char printableRand() { return rand() % 95 + 32; }
char graphicalRand() { return rand() % 94 + 33; }
char punctRand() {
    int flag = rand() % 4;
    return flag == 0 ? rand() % 15 + 33 : flag == 1 ? rand() % 7 + 58 : flag == 2 ? rand() % 6 + 91 : rand() % 4 + 123 ;
}
string randomFirstName() {
    fstream ifs;
    ifs.open("dataResources/firstName.txt");
    if (ifs.fail()) throw "Cannot open dataResources/firstName.txt";
    vector<string> vect;
    string line;
    while (!ifs.eof()) {
        getline(ifs, line);
        if (line.length() > 0) vect.push_back(line);
    }
    ifs.close();
    //srand(time(0));
    return vect[rand() % vect.size()];
}

string randomLastName() {
    fstream ifs;
    ifs.open("dataResources/lastName.txt");
    if (ifs.fail()) throw "Cannot open dataResources/lastName.txt";
    vector<string> vect;
    string line;
    while (!ifs.eof()) {
        getline(ifs, line);
        if (line.length() > 0) vect.push_back(line);
    }
    ifs.close();
    //srand(time(0));
    return vect[rand() % vect.size()];
}

Date randomBirthDate () {
    //srand(time(0));
    Date res;
    res.year = rand() % 21 + 1980;
    res.month = rand() % 12 + 1;
    int maxDay;
    switch (res.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            maxDay = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            maxDay = 30;
            break;
        default:
            maxDay = 28;
            break;
    }
    res.day = rand() % maxDay + 1;
    return res;
}

Date randomDateOfIssue (Date birthDay, int yearAfter) {
    //srand(time(0));
    Date res;
    res.year = birthDay.year + yearAfter;
    res.month = rand() % 12 + 1;
    int maxDay;
    switch (res.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            maxDay = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            maxDay = 30;
            break;
        default:
            maxDay = 28;
            break;
    }
    res.day = rand() % maxDay + 1;
    return res;
}

void toLower(string& s) {
    int len = s.length();
    for (int i = 0; i < len; i++) s[i] = tolower(s[i]);
}

string randomUsername(string firstName, string lastName, Date birthDay) {
    toLower(firstName);
    toLower(lastName);
    return firstName + string(".") + lastName + to_string(birthDay.day) + to_string(birthDay.month);
}

string randomEmail(string firstName, string lastName, Date birthDay) {
    toLower(firstName);
    toLower(lastName);
    return firstName + string(".") + lastName + to_string(birthDay.day) 
            + to_string(birthDay.month) + string("@gmail.com");
}
string randomPassword() {
    string res;
    int len = rand() % 20 + 8;
    for (int i = 0; i < len; i++) res.push_back(alphaNumRand());
    return res;
}

string randomNationIDNumber() {
    string res;
    for (int i = 0; i < 9; i++) res.push_back(digitRand());
    return res;
}
#pragma endregion RANDOM_FUNCTION

#pragma region TABLE
#pragma region Person
struct Person {
    NullableInt profileNumber;
    NullableString username;
    NullableString passwd;
    NullableInt gender;
    NullableString permanentAddress;
    NullableDate dateOfBirth;
    NullableString firstName;
    NullableString middleName;
    NullableString lastName;
    NullableString nationality;
    NullableString nationalIDNumber;
    NullableDate nationalIDIssueDate;
    NullableString passportNumber;
    NullableString passportPlaceOfIssue;
    NullableDate passportDateOfIssue;
    NullableDate passportDateOfExpiry;
    NullableString profilePhotoURL;
    string sqlInsertCommand() {
        return string("INSERT INTO Person VALUES(")
                + profileNumber.sqlFormat() + string(", ")
                + username.sqlFormat() + string(", ")
                + passwd.sqlFormat() + string(", ")
                + gender.sqlFormat() + string(", ")
                + permanentAddress.sqlFormat() + string(", ")
                + dateOfBirth.sqlFormat() + string(", ")
                + firstName.sqlFormat() + string(", ")
                + middleName.sqlFormat() + string(", ")
                + lastName.sqlFormat() + string(", ")
                + nationality.sqlFormat() + string(", ")
                + nationalIDNumber.sqlFormat() + string(", ")
                + nationalIDIssueDate.sqlFormat() + string(", ")
                + passportNumber.sqlFormat() + string(", ")
                + passportPlaceOfIssue.sqlFormat() + string(", ")
                + passportDateOfIssue.sqlFormat() + string(", ")
                + passportDateOfExpiry.sqlFormat() + string(", ")
                + profilePhotoURL.sqlFormat() + string(");");
    }
};
#pragma endregion PERSON
#pragma region TickLabIDCard
//Todo
#pragma endregion TickLabIDCard
#pragma endregion TABLE

#pragma region main
int main() {
    fstream fs;
    try {  
        /**
         * Section: generate Person table data
        */
        fs.open("InsertPerson.sql", ios::out);
        if (fs.fail()) throw "Unable to open file InsertPerson.sql";
        vector<Person> personVect;
        for (int i = 0; i < 1000; i++) {
            Person temp;
            temp.profileNumber = i;
            temp.dateOfBirth = randomBirthDate();
            temp.firstName = randomFirstName();
            temp.lastName = randomLastName();
            temp.username = randomUsername(temp.firstName, temp.lastName, temp.dateOfBirth);
            temp.passwd = randomPassword();
            temp.gender = rand() % 2;
            temp.nationality = "Viet Nam";
            temp.nationalIDNumber = randomNationIDNumber();
            temp.nationalIDIssueDate = randomDateOfIssue(temp.dateOfBirth, 15 + rand() % 3);
            fs << temp.sqlInsertCommand() << endl;
            personVect.push_back(temp);
        }
        fs.close();
        /**
         * Section: generate TickLab ID Card table data
        */
        
    }
    catch (const char* msg) {
        cerr << "--------------ERROR-------------" << endl;
        cerr << msg << endl;
        cerr << "--------------------------------" << endl;
    }
    catch (...) {
        cerr << "Something went wrong!" << endl;
    }
    return 0;
}
#pragma endregion main