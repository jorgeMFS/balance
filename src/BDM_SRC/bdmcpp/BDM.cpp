// Block Decomposition Method implementation in C++ ver. 1.1 (optimized version)
// All rights reserved Fernando Soler-Toscano and Hector Zenil
// Algorithmic Nature Group (www.algorithmicnature.org)
// 
// The software on this web site, whether in the form of source code or executable, is provided As Is.
// BDM is Free Software distributed under the GNU General Public License.
// This means you are free to distribute and modify citing the source and making your own version available under the same 
// GPL license. Be sure to read the license. http://www.gnu.org/licenses/gpl.html 
//
// To Compile: $ g++ -o bdm BDM.cpp -lgmp -lm
//
// Operation: BDM < file
// 
// It generates the program 'bdm'. Execution with the test file: 
// ./bdm < test.txt 
// 
// It you want that the output is stored in file.txt: 
// ./bdm < test.txt  > file.txt

#include <stdlib.h> 
#include <math.h>   
#include <gmp.h>
#include <iostream>
#include <sstream>
#include <map>
#include <fstream>
#include <vector>
#include <stdio.h>
#include <values.h>


using namespace std;

float complexities[65536];


// UTILITIES
vector<string> &split(const string &s, char delim, vector<string> &elems) {
    stringstream ss(s);
    string item;
    while(getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}
vector<string> split(const string &s, char delim) {
    vector<string> elems;
    return split(s, delim, elems);
}

int bdm(map<int,unsigned int> squares){

  unsigned long long n = 1;
  mpf_t Ksq, acum, ns;
  mpf_init_set_str(Ksq,"0",10);
  mpf_init_set_str(acum,"0",10);
  float ff = 0;
  
  for( map<int,unsigned int>::iterator ii=squares.begin(); ii!=squares.end(); ++ii)
    {
      mpf_init_set_d(acum, complexities[(*ii).first]);
      mpf_add(Ksq, Ksq, acum);
      ff=ff+(log(n*((*ii).second))/log(2));
    };   

  mpf_init_set_d(ns,ff);
  mpf_add(Ksq, Ksq, ns);  
  gmp_printf("%.*Ff\n", 10, Ksq);
  mpf_clear(ns);
  mpf_clear(Ksq);
  mpf_clear(acum);
  return 0;

}

// Returns a map with the composing squares and their number of occurrences
map<int,unsigned int> read_squares(vector<string> splitS, int size){

  int i,j;
  i=size;

  int row,column;

  int n,square;

  map<int,unsigned int> res;
  
  while(i<=splitS.size()){
    
    // read a line of blocks
    j=size;
    while(j<=splitS[0].size()){
      
      // Create a subarray
      n=32768;
      square=0;
      for(row=i-size;row<i;row++){
	for(column=j-size;column<j;column++){
	  if(splitS[row][column]=='1'){
	    square+=n;
	  }
	  n=n/2;
	}
      }      
      res[square]++;
      j+=size;
    }
    i+=size;
  }
  
  return res;


}

void load_complexities(){
  ifstream infile;  
  string line;  

  int n;

  try{
    infile.open("complexities.txt", ifstream::in);    
    for(n=0;n<65536;n++){
      getline(infile,line);
      complexities[n]=atof(line.c_str());
    }
  
    infile.close();
  } 
  catch(int e){
    cout << "There was a problem reading the complexities file" << endl;
    cout << "Check there is a file called 'complexities.txt' with the right syntax" << endl;
    exit(0);
  }
}

int main(int argn, char* argv[]) {

  load_complexities();

  string input_line;
  vector<string> splitS;
  map<int,unsigned int>res;
  
  // For stdin:
  while(cin) {
    input_line="";
    getline(cin, input_line);
    if(input_line != ""){
      splitS=split(input_line,'-');
      res=read_squares(splitS,4);    
      bdm(res);
    }
  };
 

}



