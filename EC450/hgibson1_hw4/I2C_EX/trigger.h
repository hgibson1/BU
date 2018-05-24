/*
 * triggers.h
 *
 *  Created on: Dec 11, 2015
 *      Author: hgibson1
 */

#ifndef TRIGGER_H_
#define TRIGGER_H_

#define TRIGGERPORT(X) P2##X
#define TRIGGERBIT 0x08

void init_trigger(void);
void trigger(void);

#endif /* TRIGGER_H_ */
