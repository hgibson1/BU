//
//  LinkedList.h
//  Linked_List_Template
//

#ifndef LinkedList_h
#define LinkedList_h

#include <stdio.h>
#include <iostream>
using namespace std;

/* A singly-linked list node */
template <class T = int>
struct Node
{
    T data;
    Node<T> *next;
};

/* A class for a singly-linked list */
template <class T = int>
class LinkedList {
	public:
		LinkedList() {
        		listSize = 0;
        		head = new Node<T>;
        		head->data = 0;
        		head->next = NULL;
		}

		~LinkedList() {
        		Node<T> *current = head;
        		Node<T> *next;
        		for (int i = 0; i < listSize; i++) {
                		next = current->next;
                		free(current);
                		current = next;
        		}
        		free(head);
		}

		int size() {
        		return listSize;
		}

		bool contains(T x) {
        		Node<T> *current = head;
        		for (int i = 0; i < listSize; i++) {
                		if (current->data == x) {
                        		return true;
                		}
                		current = current->next;
        		}
        		return false;
		}

		bool add(T x) {
        		Node<T> *current = head;
        		for (int i = 0; i < listSize; i++) {
                		if (current->data == x) {
                        		return false;
                		}
                		current = current->next;
        		}
        		Node<T> *added = new Node<T>;
        		added->data = x;
        		added->next = NULL;
        		current->next = added;
        		listSize++;
        		return true;
		}

		bool remove(T x) {
        		Node<T> *current = head;
        		Node<T> *temp = head;
        		for (int i = 0; i < listSize; i++) {
                		if (current->data == x) {
                        		temp->next = current->next;
                        		free(current);
                        		listSize--;
                        		return true;
                		}
                		temp = current;
               			current = current->next;
        		}
        		return false;
		}

		void print() {
        		Node<T> *current = head->next;
        		for (int i = 0; i < listSize; i++) {
                		cout << current->data << " ";
                		current = current->next;
        		}
        		cout << "\n";
		}

private:
	Node<T> *head;         // Pointer to head of singly-linked list
	int listSize;       // Size of singly-linked list

};

#endif /* LinkedList_h */
