/* @BEGIN_OF_SOURCE_CODE */
#include <iostream>
#include <cstdio>
#include <fstream>
#include <algorithm>
#include <vector>
#include <list>
#include <string>
#include <set>
#include <map>
#include <cstring>
#include <stack>
#include <queue>
#include <cmath>
#include <iterator>
#include <ctime>
#include <deque>
#include <climits>
#include <sstream>
#include <utility>
#include <bitset>

#define EACH(i, obj) for (auto i = obj.begin(); i != obj.end(); ++i)
#define REACH(i, obj) for (auto i = obj.rbegin(); i != obj.rend(); ++i)
#define REP(i, val, b) for (int i = val; i <= b; ++i)
#define RREP(i, val, b) for (int i = val; i >= b; --i)
#define ALL(obj) obj.begin(), obj.end()
#define RALL(obj) obj.rbegin(), obj.rend()
#define DSET(obj, size, val) REP(z, 0, size - 1) obj[z] = val
#define RESET(val) memset(val, 0, sizeof(val))
#define MP(a,b) make_pair(a, b)
#define REMOVE(obj, condition) obj.erase(remove(ALL(obj), condition), obj.end())
#define OR |
#define AND &
#define XOR ^
#define MOD %
#define oo 2000000000	// INF

#define ROOT(a) (a - 1) / 2
#define LEFT(a) 2 * a + 1
#define RIGHT(a) 2 * a + 2

using namespace std;

typedef pair<int, int> pii; // Pair: int-int
typedef pair<string, int> psi; // Pair: sring-int
typedef vector<int> vi; // Vector: int
typedef vector<vi> AdjMat; // AdjMatrix(graph), 2D dynamic array
typedef vector<pii> AdjList; // Adjacent List(graph)
typedef vector<psi> vpsi; // Vector: pair: string-int
typedef vector<string> vs; // Vector: string
typedef set<int> seti; // Set: int
typedef set<char> setc; // Set: char
typedef map<string, int> msi; // Map: string int
typedef map<int, int> mii; // Map: int-int
typedef priority_queue <pair<int, pii>> EdgeList; // EdgeList(graph): Structure holds weight and pair of vetices
typedef vi::iterator viit; // Vector iterator
typedef vector<viit> vviit; // Vector of vector iterator
typedef long long ll;
typedef string::iterator strit;

void print(int[], int);
void swap(int&, int&);
bool isAscending(int[], int);

void selectionSort(int[], int);
void bubbleSort(int[], int);
void insertionSort(int[], int);

void quickSort(int[], int);
void quickSortBuild(int[], int, int);

void mergeSort(int[], int);
void mergeSortBuild(int[], int ,int);
void splitAndMerge(int[], int, int, int);

void heapSort(int[], int);
void swapHeap(int[], int, int);
void reArrange(int[], int);
void extract(int[], int);

string verdict[] = {"WRONG ANSWER", "ACCEPTED"};

int main() {
	int arr[] = {74,97,89,27,982,89,75,2,893,7,474,6,5,410,83,4,3,9,740,24,73};
	int n = sizeof(arr) / sizeof(arr[0]);
	
//	selectionSort(arr, n);
//	bubbleSort(arr ,n);
//	insertionSort(arr, n);
//	quickSort(arr, n);
//	mergeSort(arr, n);
	heapSort(arr, n);
	
	print(arr, n);
	cout << verdict[isAscending(arr, n)] << endl;
	return 0;
}

void print(int arr[], int n) {
	REP(i, 0, n - 1) {
		cout << arr[i] << " ";
	}
	cout << endl;
}
void swap(int& a, int& b) {
	int temp = a;
	a = b;
	b = temp;
}
bool isAscending(int arr[], int n) {
	REP(i, 0, n - 2) {
		if (arr[i] > arr[i + 1])
			return false;
	}
	return true;
}
void selectionSort(int arr[], int n) {
	REP(i, 0, n - 2) {
		int minNum = arr[i];
		int index = i;
		REP(j, i + 1, n - 1) {
			if (arr[j] < minNum) {
				minNum = arr[j];
				index = j;
			}
		}
		swap(arr[i], arr[index]);
	}
}
void bubbleSort(int arr[], int n) {
	RREP(i, n - 1, 0) {
		REP(j, 0, i) {
			if (arr[j] > arr[j + 1])
				swap(arr[j], arr[j + 1]);
		}
	}
}
void insertionSort(int arr[], int n) {
	REP(i, 1, n - 1) {
		int current = arr[i];
		int j = i - 1;
		while (j >= 0 && current < arr[j]) {
			arr[j + 1] = arr[j];
			--j;
		}
		arr[j + 1] = current;
	}
}
void quickSort(int arr[], int n) {
	quickSortBuild(arr, 0, n - 1);
}

void quickSortBuild(int arr[], int left, int right) {
	int i = left, j = right;
	int pivot = arr[(left + right) / 2];
	while (i <= j) {
		while (arr[i] < pivot)	++i;
		while (arr[j] > pivot)	--j;
		if (i <= j) {
			swap(arr[i], arr[j]);
			++i; --j;
		}
	}
	if (left < j)	quickSortBuild(arr, left, j);
	if (right > i)	quickSortBuild(arr, i, right);
}
void mergeSort(int arr[], int n) {
	mergeSortBuild(arr, 0, n - 1);
}
void mergeSortBuild(int arr[], int left, int right) {
	if (left >= right) return;
	
	int mid = (left + right) / 2;
	
	mergeSortBuild(arr, left, mid);
	mergeSortBuild(arr, mid + 1, right);
	
	splitAndMerge(arr, left, right, mid);//TODO : kill mid, reserve slot for asc
}
void splitAndMerge(int arr[], int left, int right, int mid) {
	int leftSize = mid - left + 2, rightSize = right - mid + 1;
	int leftPart[leftSize], rightPart[rightSize];
	REP(i, 0, leftSize - 2) {
		leftPart[i] = arr[i + left];
	}
	leftPart[leftSize - 1] = INT_MAX;
	
	REP(i, 0, rightSize - 2) {
		rightPart[i] = arr[i + mid + 1];
	}
	rightPart[rightSize - 1] = INT_MAX;
	
	int x = 0, y = 0;
	REP(i, left, right) {
		if (leftPart[x] < rightPart[y]) {
			arr[i] = leftPart[x++];
		}
		else {
			arr[i] = rightPart[y++];
		}
	}
}
void heapSort(int arr[], int n) {
	reArrange(arr, n);
	extract(arr, n);
	if (n != 1) {
		swap(arr[0], arr[1]);
	}
}
void swapHeap(int arr[], int n, int cur) {
	if (cur > (n - 2) / 2) return;
	int candidate;
	if (RIGHT(cur) >= n) candidate = LEFT(cur);
	else {
		candidate = arr[LEFT(cur)] > arr[RIGHT(cur)] ? LEFT(cur) : RIGHT(cur);
	}
	if (arr[cur] < arr[candidate]) {
		swap(arr[cur], arr[candidate]);
		swapHeap(arr, n, candidate);
	}
}
void extract(int arr[], int n) {
	if (n == 1) return;
	else {
		swap(arr[0], arr[n - 1]);
		int m = n - 1;
		swapHeap(arr, m, 0);
		extract(arr, n - 1);
	}
}
void reArrange(int arr[], int n) {
	RREP(i, (n - 2) / 2, 0) {
		swapHeap(arr, n, i);
	}
}
/* @END_OF_ SOURCE_CODE */
