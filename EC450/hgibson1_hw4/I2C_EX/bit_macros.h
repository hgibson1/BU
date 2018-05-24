/*
 * bit_macros.h
 *
 *  Created on: Dec 11, 2015
 *      Author: hgibson1
 */

#ifndef BIT_MACROS_H_
#define BIT_MACROS_H_

// helpful macros
#define BIC(location,mask) ((location) &= ~(mask))
#define BIS(location,mask) ((location) |= (mask))

#endif /*BIT_MACROS_H_*/
