//
//  MyBST.cpp
//  bst_transform
//

#include "MyBST.h"

/**
 * Computes how to transform this MyBST into the target MyBST using rotations.
 * Returns a vector of rotations indicating which rotations around which nodes
 *  must be performed to transform this into the target.
 *
 * IMPORTANT: We want to transform T1 into T2 so the call should look like
 * rotations = t1.transform(t2)
 */

vector<Rotation> MyBST::transform(MyBST target) {

  /*** This is what you have to do ***/
    	
}


Node* MyBST::rotateRight(Node* Q)
{
    Node* P = Q->left;
    Q->left = P->right;
    P->right = Q;
    return P;
}

Node* MyBST::rotateLeft(Node* P)
{
    Node* Q = P->right;
    P->right = Q->left;
    Q->left = P;
    return Q;
}
