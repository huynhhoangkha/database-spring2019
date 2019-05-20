#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <ctime>
#include <cstdlib>
using namespace std;

#pragma region DATA_DEFINE
enum sex { MALE = 1, FEMALE = 0 };
struct Date { int day, month, year; };

template <class T>
class Nullable {
protected:
	T data;
public:
	virtual bool isNull() = 0;
	virtual operator T() = 0;
	virtual string mssqlFormat() = 0;
};

class NullableString : public Nullable<string> {
public:
	NullableString(string _data = string()) { this->data = _data; }
	NullableString operator=(const char* _data) { this->data = string(_data); return *this; }
	NullableString(const NullableString &obj) { this->data = obj.data; }
	bool isNull() { return (data.length() == 0); }
	operator string() { return this->data; }
	bool operator==(NullableString& rhs) { return this->data == rhs.data; }
	string mssqlFormat() {
		if (this->isNull()) return string("NULL");
		else return string("'") + data + string("'");
	}
	NullableString operator+(const NullableString &rhs) {
		return NullableString(this->data + rhs.data);
	}
	friend ostream& operator<<(ostream& out, NullableString& obj);
};

ostream& operator<<(ostream& out, NullableString& obj) {
	out << obj.mssqlFormat();
	return out;
}

class NullableDate : public Nullable<Date> {
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
	bool operator==(NullableDate& date) {
		return this->data.day == date.data.day
			&& this->data.month == date.data.month
			&& this->data.year == date.data.year;
	}
	bool isNull() { return !this->initialized; };
	operator Date() { return this->data; };
	string mssqlFormat() {
		if (this->isNull()) return string("NULL");
		else {
			string day = to_string(this->data.day);
			while (day.length() < 2) day.insert(day.begin(), '0');
			string month = to_string(this->data.month);
			while (month.length() < 2) month.insert(month.begin(), '0');
			string year = to_string(this->data.year);
			return string("CONVERT(DATETIME, ")
				+ day + string("-")
				+ month + string("-")
				+ year + string(", 105)");
		}
	}
	friend ostream& operator<<(ostream& out, NullableDate& obj);
};

ostream& operator<<(ostream& out, NullableDate& obj) { out << obj.mssqlFormat(); return out; }

class NullableInt : Nullable<int> {
	bool initialized;
public:
	NullableInt() { this->initialized = false; }
	NullableInt(int _value) { this->data = _value; this->initialized = true; }
	bool isNull() { return !this->initialized; };
	operator int() { return this->data; }
	operator string() { return to_string(this->data); }
	bool operator==(NullableInt& i) { return this->data == i.data; }
	string mssqlFormat() { return this->isNull() ? string("NULL") : to_string(this->data); }
	friend ostream& operator<<(ostream& out, NullableInt& obj);
};

ostream& operator<<(ostream& out, NullableInt& obj) { out << obj.mssqlFormat(); return out; }

#pragma endregion DATA_DEFINE

#pragma region Utilities
template <typename T>
bool existIn(vector<T> vect, T key) {
	int vectSize = vect.size();
	for (int i = 0; i < vectSize; i++) if (vect[i] == key) return true;
	return false;
}
#pragma endregion Utilities

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
	return flag == 0 ? rand() % 15 + 33 : flag == 1 ? rand() % 7 + 58 : flag == 2 ? rand() % 6 + 91 : rand() % 4 + 123;
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

Date randomBirthDate() {
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

Date randomDateOfIssue(Date birthDay, int yearAfter) {
	//srand(time(0));
	Date res;
	res.year = birthDay.year + yearAfter;
	if (res.year > 2018) res.year = 2018;
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
	vector<string> domain;
	domain.push_back(string("gmail.com"));
	domain.push_back(string("hotmail.com"));
	domain.push_back(string("yahoo.com"));
	return firstName + string(".") + lastName + to_string(birthDay.day)
		+ to_string(birthDay.month) + string("@") + domain[rand() % 3];
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

string randomPhoneNumber () {
	string res;
	res.push_back('0');
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
    NullableInt projectFundContributor;
	string mssqlInsertCommand() {
		return string("INSERT INTO Person VALUES(")
			+ profileNumber.mssqlFormat() + string(", ")
			+ username.mssqlFormat() + string(", ")
			+ passwd.mssqlFormat() + string(", ")
			+ gender.mssqlFormat() + string(", ")
			+ permanentAddress.mssqlFormat() + string(", ")
			+ dateOfBirth.mssqlFormat() + string(", ")
			+ firstName.mssqlFormat() + string(", ")
			+ middleName.mssqlFormat() + string(", ")
			+ lastName.mssqlFormat() + string(", ")
			+ nationality.mssqlFormat() + string(", ")
			+ nationalIDNumber.mssqlFormat() + string(", ")
			+ nationalIDIssueDate.mssqlFormat() + string(", ")
			+ passportNumber.mssqlFormat() + string(", ")
			+ passportPlaceOfIssue.mssqlFormat() + string(", ")
			+ passportDateOfIssue.mssqlFormat() + string(", ")
			+ passportDateOfExpiry.mssqlFormat() + string(", ")
            + projectFundContributor.mssqlFormat() + string(", ")
			+ profilePhotoURL.mssqlFormat() + string(");");
	}
};
#pragma endregion PERSON
#pragma region TickLabIDCard
struct TickLabIDCard {
	NullableInt profileNumber;
	NullableDate dateOfIssue;
	NullableString rfidNumber;
	string mssqlInsertCommand() {
		return string("INSERT INTO TickLabIDCard VALUES(")
			+ profileNumber.mssqlFormat() + string(", ")
			+ dateOfIssue.mssqlFormat() + string(", ")
			+ rfidNumber.mssqlFormat() + string(");");
	}
};
#pragma endregion TickLabIDCard
#pragma region PersonEmailAddress
struct PersonEmailAddress {
	NullableInt profileNumber;
	NullableString emailAddress;
	string mssqlInsertCommand() {
		return string("INSERT INTO PersonEmailAddress VALUES(")
			+ profileNumber.mssqlFormat() + string(", ")
			+ emailAddress.mssqlFormat() + string(");");
	}
};
#pragma endregion PersonEmailAddress

#pragma region PersonPhoneNumber
struct PersonPhoneNumber {
	NullableInt profileNumber;
	NullableString phoneNumber;
	string mssqlInsertCommand() {
		return string("INSERT INTO PersonPhoneNumber VALUES(")
		+ profileNumber.mssqlFormat() + string(", ")
		+ phoneNumber.mssqlFormat() + string(");");
	}
};
#pragma endregion PersonPhoneNumber

#pragma region Department
struct Department {
	NullableInt departmentID;
	NullableString departmentName;
	NullableString departmentDescription;
	string mssqlInsertCommand() {
		return string("INSERT INTO Department VALUES(")
			+ departmentID.mssqlFormat() + string(", ")
			+ departmentName.mssqlFormat() + string(", ")
			+ departmentDescription.mssqlFormat() + string(");");
	}
};
#pragma endregion Department

#pragma region WorkPosition
struct WorkPosition {
	NullableInt posID;
	NullableString posName;
	NullableString posDescription;
	NullableInt posInDepartment;
	string mssqlInsertCommand() {
		return string("INSERT INTO WorkPosition VALUES(")
			+ posID.mssqlFormat() + string(", ")
			+ posName.mssqlFormat() + string(", ")
			+ posDescription.mssqlFormat() + string(", ")
			+ posInDepartment.mssqlFormat() + string(");");
	}
};
#pragma endregion WorkPosition

#pragma region Taking
struct Taking {
	NullableInt profileNumberTake;
	NullableInt posIDTake;
	NullableDate takeFromdate;
	NullableDate takeToDate;
	string mssqlInsertCommand() {
		return string("INSERT INTO Taking VALUES(")
			+ profileNumberTake.mssqlFormat() + string(", ")
			+ posIDTake.mssqlFormat() + string(", ")
			+ takeFromdate.mssqlFormat() + string(", ")
			+ takeToDate.mssqlFormat() + string(");");
	}
};
#pragma endregion Taking

#pragma region Project
struct Project {
	NullableInt projectID;
	NullableString projectName;
	NullableDate projectStartTime;
	NullableDate projectEndTime;
	NullableString projectStatus;
	NullableDate expectedFinishTime;
	NullableString projectDescription;
	NullableInt TickLabBudget;
	NullableInt projectManagerProfileNumber;
	NullableInt belongToDepartmentHave;
	string mssqlInsertCommand() {
		return string("INSERT INTO Project VALUES(")
			+ projectID.mssqlFormat() + string(", ")
			+ projectName.mssqlFormat() + string(", ")
			+ projectStartTime.mssqlFormat() + string(", ")
			+ projectEndTime.mssqlFormat() + string(", ")
			+ projectStatus.mssqlFormat() + string(", ")
			+ expectedFinishTime.mssqlFormat() + string(", ")
			+ projectDescription.mssqlFormat() + string(", ")
			+ TickLabBudget.mssqlFormat() + string(", ")
			+ projectManagerProfileNumber.mssqlFormat() + string(", ")
			+ belongToDepartmentHave.mssqlFormat() + string(");");
	}
};
#pragma endregion Project

#pragma endregion TABLE

#pragma region main
int main() {
	int count;
	fstream ofs;
	fstream ifs;
	string line;
	try {
		/**
		 * Section: generate Person table data
		*/
		ofs.open("InsertPerson.sql", ios::out);
		vector<Person> personVect;
		for (int i = 0; i < 30; i++) {
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
			ofs << temp.mssqlInsertCommand() << endl;
			personVect.push_back(temp);
		}
		ofs.close();
		/**
		 * Section: generate TickLab ID Card table data
		*/
		ofs.open("InsertTickLabIDCard.sql", ios::out);
		int numberOfPerson = personVect.size();
		int temp;
		vector<TickLabIDCard> ticklabIDCardVect;
		for (int i = 0; i < numberOfPerson; i++) {
			temp = rand() % 2 + 1;
			for (int j = 0; j < temp; j++) {
				TickLabIDCard card;
				card.profileNumber = personVect[i].profileNumber;
				card.rfidNumber = randomNationIDNumber();
				card.dateOfIssue = randomDateOfIssue(personVect[i].dateOfBirth, 18 + rand() % 5);
				ticklabIDCardVect.push_back(card);
				ofs << card.mssqlInsertCommand() << endl;
			}
		}
		ofs.close();
		/**
		 * Email address generate
		*/
		ofs.open("InsertEmailAddress.sql", ios::out);
		vector<NullableString> emailStrVect;
		vector<PersonEmailAddress> personEmailAddressVect;
		for (int i = 0; i < numberOfPerson; i++) {
			temp = rand() % 3 + 1;
			for (int j = 0; j < temp; j++) {
				PersonEmailAddress email;
				email.profileNumber = personVect[i].profileNumber;
				email.emailAddress = randomEmail(personVect[i].firstName, personVect[i].lastName, personVect[i].dateOfBirth);
				while (existIn(emailStrVect, email.emailAddress)) {
					email.emailAddress = randomEmail(personVect[i].firstName, personVect[i].lastName, personVect[i].dateOfBirth);
				}
				emailStrVect.push_back(email.emailAddress);
				personEmailAddressVect.push_back(email);
				ofs << email.mssqlInsertCommand() << endl;
			}
		}
		ofs.close();
		/**
		 * Person phone number generate
		*/
		ofs.open("InsertPersonPhoneNumber.sql", ios::out);
		vector<PersonPhoneNumber> personPhoneNumberVect;
		for (int i = 0; i < numberOfPerson; i++) {
			temp = rand() % 3 + 1;
			for (int j = 0; j < temp; j++) {
				PersonPhoneNumber phoneNumber;
				phoneNumber.profileNumber = i;
				phoneNumber.phoneNumber = randomPhoneNumber();
				personPhoneNumberVect.push_back(phoneNumber);
				ofs << phoneNumber.mssqlInsertCommand() << endl;
			}
		}
		ofs.close();
		/**
		 * Department data generate
		*/
		ofs.open("InsertDepartment.sql", ios::out);
		ifs.open("dataResources/department.txt", ios::in);
		vector<string> departmentNameVect;
		while (!ifs.eof()) {
			getline(ifs, line);
			if (line.length()) departmentNameVect.push_back(line);
		}
		ifs.close();
		vector<Department> departmentVect;
		int numberOfDepartment = departmentNameVect.size();
		for (int i = 0; i < numberOfDepartment; i++) {
			Department department;
			department.departmentID = i;
			department.departmentName = departmentNameVect[i];
			ofs << department.mssqlInsertCommand() << endl;
			departmentVect.push_back(department);
		}
		ofs.close();
		/**
		 * generate job position
		*/
		ifs.open("dataResources/position.txt", ios::in);
		vector<string> strPosNameVect;
		while (!ifs.eof()) {
			getline(ifs, line);
			if (line.length()) strPosNameVect.push_back(line);
		}
		ifs.close();
		ofs.open("InsertWorkPosition.sql", ios::out);
		int numberOfWorkPos = strPosNameVect.size();
		vector<WorkPosition> workPositionVect;
		WorkPosition workPos;
		count = 0;
		for (int i = 0; i < numberOfDepartment; i++) {
			for (int j = 0; j < numberOfWorkPos; j++) {
				workPos.posID = count++;
				workPos.posInDepartment = departmentVect[i].departmentID;
				workPos.posName = departmentVect[i].departmentName 
					+ NullableString(string(" ")) + NullableString(strPosNameVect[j]);
				workPositionVect.push_back(workPos);
				ofs << workPos.mssqlInsertCommand() << endl;
			}
		}
		ofs.close();
		/**
		 * generate Taking table data
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