#include "LinkedList.h"
#include <iostream>
using namespace std;

LinkedList::LinkedList() {
	listSize = 0;
	head = new Node;
	head->data = 0;
	head->next = NULL;	
}

LinkedList::~LinkedList() {
	Node *current = head;
	Node *next;
	for (int i = 0; i < listSize; i++) {
		next = current->next;
		free(current);
		current = next;
	}
	free(head);
}

int LinkedList::size() {
	return listSize;
}

bool LinkedList::contains(int x) {
	Node *current = head;
	for (int i = 0; i < listSize; i++) {
		if (current->data == x) {
			return true;
		}
		current = current->next;
	}
	return false;
}

bool LinkedList::add(int x) {
	Node *current = head;
	for (int i = 0; i < listSize; i++) {
		if (current->data == x) {
			return false;
		}
		current = current->next;
	}
	Node *added = new Node;
	added->data = x;
	added->next = NULL;
	current->next = added;
	listSize++;
	return true;
}

bool LinkedList::remove(int x) {
	Node *current = head;
	Node *temp = head;
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

void LinkedList::print() {
	Node *current = head->next;
	for (int i = 0; i < listSize; i++) {
		cout << current->data << " ";
		current = current->next;
	}
	cout << "\n";
}
