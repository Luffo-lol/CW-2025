#include <iostream>
#include <vector>
#include <fstream>
#include <string>


using namespace std;

class Problem {
    //constant and data used for this
    public:
        string inFileName;
        int scheme;
        long double T;
        long double dt;
        long double g;
        long double rho;
        long double Cd;
        vector<vector<long double>> data; //m, A, K, y_0, v_0, h_0
        vector<vector<vector<long double>>> evaluatedMatrix;


    Problem(string filename){ 
        inFileName = filename;
        readFile(filename);
        cout << "File Read" << endl;
        cout << "System Conditions - Scheme: " << scheme << " T = " << T << " dt = " << dt << " g = " << g << " rho = " << rho << " Cd = " << Cd << endl;   
    }

    void solveProblem(){
        generateMatrix();
        cout << "Matrix Generated" << endl;
        saveToFile();
        cout << "Files Saved" << endl;
    }

    int readFile (string filename){
        std::ifstream file("readFiles/" + filename);
        vector<long double> constants; //Scheme, T, dt, g, rho, Cd

        if (!file) {
            cout << "Error: Could not open file " << filename << endl;
            exit (1);
        }

        string line;
        while (line.empty()||line[0] != '#') { //finds first line to find constant values
            getline(file,line);
        }

        getline(file,line);//changes sting to correct line to read values

        string temp = "";//temp string to hold numbers

        for (char c : line) {
            if (c != ' ') {
                temp += c;  // Add character to temp if it's not a space'
            } 
            else {
                if (!temp.empty()) {
                    constants.push_back(stod(temp));  // Convert temp to an integer and add it to the vector
                    temp = "";  // Reset temp for the next number
                }
            }
        }
        if (!temp.empty()){
            constants.push_back(stod(temp));  // Converts final element
            temp = "";
        }


        scheme = constants[0];
        T = constants[1];
        dt = constants[2];
        g = constants[3];
        rho = constants[4];
        Cd = constants[5];
        constants.clear();//clearing memory

        while (getline(file,line)) { //finds and saves data for remaining lines
            vector<long double> row;
            if (line[0] != '#'){
                for (char c : line) {
                    if (c != ' ') {
                        temp += c;  // Add character to temp if it's not a space
                    } 
                    else {
                        if (!temp.empty()) {
                            row.push_back(stod(temp));  // Convert temp to a double and add it to the vector
                            temp = "";  // Reset temp for the next number
                        }
                    }
                }
                if (!temp.empty()){
                    row.push_back(stod(temp));  // Converts final element
                    temp = "";
                }
                data.push_back(row);
            }
        }
        file.close();//closes file to prevent errors if other files are opened

        if (dt <= 0 || T <= 0) {
            cout << "Error: Invalid time step or total time." << endl;
            exit(1);
        }
        if (data.empty()) {
            cout << "Error: No vessel data found." << endl;
            exit(1);
        }

        return 0;
    }      

    long double finddh (long double m, long double A, long double K, long double yt, long double ht){
        return  (K/(rho*A) * (m/(rho*A) + yt - ht));
    }

    long double findAcc (long double m, long double A, long double K, long double yt, long double vt, long double ht){
        return ((rho*A)/(m + rho*A*ht)) * (2.0*g*ht - g*yt - 0.5*Cd*abs(vt)*vt);
    }


    vector<vector<long double>> FE(long double m, long double A, long double K, long double y0, long double v0, long double h0){
        vector<vector<long double>> out;
        vector<long double> row = {0, y0, v0, h0};
        out.push_back(row);
        for(long double t = dt; t <= T + 1e-9; t += dt){//to remove floating point errors that delete final elements sometimes
            long double yn = row[1] + row[2]*dt; //calculated yn using velocity
            long double vn = row[2] + findAcc(m,A,K,row[1],row[2],row[3])*dt; //calculated vn using acceleration
            long double hn = row[3] + finddh(m,A,K,row[1],row[3])*dt;
            row = {t, yn, vn, hn};
            out.push_back(row);
        }
        cout << "Returned" << endl;
        return out;
    }

    vector<vector<long double>> RK4(long double m, long double A, long double K, long double y0, long double v0, long double h0){
        vector<vector<long double>> out;
        vector<long double> row = {0, y0, v0, h0};
        out.push_back(row);
        for(long double t = dt; t <= T + 1e-9; t += dt){//to remove floating point errors that delete final elements sometimes
            long double vk1 = dt * findAcc(m,A,K,row[1],row[2],row[3]);
            long double yk1 = dt * row[2];
            long double hk1 = dt * finddh(m,A,K,row[1],row[3]);
            
            long double vk2 = dt * findAcc(m,A,K,row[1] + yk1/2, row[2] + vk1/2, row[3] + hk1/2);
            long double yk2 = dt * (row[2] + vk1/2);
            long double hk2 = dt * finddh(m,A,K,row[1] + yk1/2,row[3] + hk1/2);

            long double vk3 = dt * findAcc(m,A,K,row[1] + yk2/2, row[2] + vk2/2, row[3] + hk2/2);
            long double yk3 = dt * (row[2] + vk2/2);
            long double hk3 = dt * finddh(m,A,K,row[1] + yk2/2,row[3] + hk2/2);

            long double vk4 = dt * findAcc(m,A,K,row[1] + yk3, row[2] + vk3, row[3] + hk3);
            long double yk4 = dt * (row[2] + vk3);
            long double hk4 = dt * finddh(m,A,K,row[1] + yk3,row[3] + hk3);
            
            //cout << "vk" << endl;
            //cout << vk1 << ", " << vk2 << ", "<< vk3 << ", " << vk4 << endl;
            //cout << "yk" << endl;
            //cout << yk1 << ", " << yk2 << ", "<< yk3 << ", " << yk4 << endl;
            //cout << "hk" << endl;
            //cout << hk1 << ", " << hk2 << ", "<< hk3 << ", " << hk4 << endl;

            long double yn = row[1] + 1.0/6.0 * (yk1 + 2*yk2 + 2*yk3 + yk4);
            long double vn = row[2] + 1.0/6.0 * (vk1 + 2*vk2 + 2*vk3 + vk4);
            long double hn = row[3] + 1.0/6.0 * (hk1 + 2*hk2 + 2*hk3 + hk4);
            row = {t, yn, vn, hn};

            //cout << "t = " << t << " y = " << yn << " v = " << vn << " hn = " << hn << endl;
            
            out.push_back(row);
        }
        cout << "t = " << row[0] << " y = " << row[1] << " v = " << row[2] << " hn = " << row[3] << endl;
        cout << "Returned" << endl;
        return out;
    }


    void generateMatrix(){//generates 3D matrix of the motion of the time, position, velocity, height for each time step for each of the vessel parameters
        
        for (int vesselNumber = 0; vesselNumber < data.size();vesselNumber++){//for each vessel being evaluated 
            cout << "Currently Porcessing VesselNumber: " << vesselNumber + 1 << endl;
            cout << "m = " << data[vesselNumber][0] << " A = " <<  data[vesselNumber][1] << " K = " <<  data[vesselNumber][2] << " y0 = " << data[vesselNumber][3] << " v0 = " << data[vesselNumber][4] << " h0 = " << data[vesselNumber][5] << endl;
            if(scheme == 0){
                evaluatedMatrix.push_back(FE(data[vesselNumber][0], data[vesselNumber][1], data[vesselNumber][2], data[vesselNumber][3], data[vesselNumber][4], data[vesselNumber][5]));
            }
            if(scheme == 1){
                evaluatedMatrix.push_back(RK4(data[vesselNumber][0], data[vesselNumber][1], data[vesselNumber][2], data[vesselNumber][3], data[vesselNumber][4], data[vesselNumber][5]));
            }
        }
    }

    void saveToFile(){
        string schemeName = "";
        if (scheme == 0){
            schemeName = "FE";
        }
        if (scheme == 1){
            schemeName = "RK4";
        }

        string outFileName = "writeFiles/positionData-" + inFileName + "-" + to_string(data.size()) + "-" + schemeName + "-dt=" + to_string(dt) + ".txt";
        ofstream outFile(outFileName);

        //outFile << inFileName << " - Vessel Number " << to_string(vesselNumber + 1) << endl;
        //outFile << "m = " << data[vesselNumber][0] << " A = " <<  data[vesselNumber][1] << " K = " <<  data[vesselNumber][2] << " y0 = " << data[vesselNumber][3] << " v0 = " << data[vesselNumber][4] << " h0 = " << data[vesselNumber][5] << endl;
        //outFile << "t " << "yn " << "vn " << "hn" << endl; 
        //outFile << "yBar = " << data[vesselNumber][0]/(rho * data[vesselNumber][1]) << endl;
        
        //outFile << "deltaT = " << dt << endl;

        cout << outFileName << endl;
        if (outFile.is_open()) {
            for(int rowNumber = 0; rowNumber < size(evaluatedMatrix[0]); rowNumber++){
                outFile << evaluatedMatrix[0][rowNumber][0] <<  ", ";
                for (int vesselNumber = 0; vesselNumber < data.size();vesselNumber++){
                    string schemeName = "";
                    outFile << evaluatedMatrix[vesselNumber][rowNumber][1] << ", " << evaluatedMatrix[vesselNumber][rowNumber][2] << ", " << evaluatedMatrix[vesselNumber][rowNumber][3] << ", ";
                    //cout << evaluatedMatrix[vesselNumber][rowNumber][0] << "," << evaluatedMatrix[vesselNumber][rowNumber][0] << "," << evaluatedMatrix[vesselNumber][rowNumber][1] << "," << evaluatedMatrix[vesselNumber][rowNumber][2] << "," << evaluatedMatrix[vesselNumber][rowNumber][3] << "," << endl;
                }
                outFile << endl;
            } 
        }
        else {
            cout << "Unable to open the file." << endl;
        }
        outFile.close();
    }
};





int main() {
    //Problem firstTest = Problem("parameters.txt");
    //firstTest.solveProblem();
    //Problem Q3Part1 = Problem("SV-ND.txt");
    //Q3Part1.solveProblem();
    //Problem Q3Part2 = Problem("SV-LD.txt");
    //Q3Part2.solveProblem();
    //Problem Q3Part3 = Problem("SinkingVessel.txt");
    //Q3Part3.solveProblem();
    Problem Q3Part4 = Problem("ThreeVessels.txt");
    Q3Part4.solveProblem();
}
