#include <vector>
#include "BST.h"

class MyBST:BST {
	vector<Rotation> transform(MyBST target);
	Node* rotateRight(Node* Q);
	Node* rotateLeft(Node* P);
};

