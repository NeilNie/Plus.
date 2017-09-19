/* ************************************************************************************* */
/* *    PhatWare WritePad SDK                                                          * */
/* *    Copyright (c) 2008-2015 PhatWare(r) Corp. All rights reserved.                 * */
/* ************************************************************************************* */

/* ************************************************************************************* *
 *
 * WritePad SDK Sample
 *
 * Unauthorized distribution of this code is prohibited. For more information
 * refer to the End User Software License Agreement provided with this
 * software.
 *
 * This source code is distributed and supported by PhatWare Corp.
 * http://www.phatware.com
 *
 * THIS SAMPLE CODE CAN BE USED  AS A REFERENCE AND, IN ITS BINARY FORM,
 * IN THE USER'S PROJECT WHICH IS INTEGRATED WITH THE WRITEPAD SDK.
 * ANY OTHER USE OF THIS CODE IS PROHIBITED.
 *
 * THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS"
 * AND WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL PHATWARE CORP.
 * BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT, SPECIAL, INCIDENTAL,
 * INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY KIND, OR ANY DAMAGES WHATSOEVER,
 * INCLUDING WITHOUT LIMITATION, LOSS OF PROFIT, LOSS OF USE, SAVINGS
 * OR REVENUE, OR THE CLAIMS OF THIRD PARTIES, WHETHER OR NOT PHATWARE CORP.
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE
 * POSSESSION, USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * US Government Users Restricted Rights
 * Use, duplication, or disclosure by the Government is subject to
 * restrictions set forth in EULA and in FAR 52.227.19(c)(2) or subparagraph
 * (c)(1)(ii) of the Rights in Technical Data and Computer Software
 * clause at DFARS 252.227-7013 and/or in similar or successor
 * clauses in the FAR or the DOD or NASA FAR Supplement.
 * Unpublished-- rights reserved under the copyright laws of the
 * United States.  Contractor/manufacturer is PhatWare Corp.
 * 1314 S. Grand Blvd. Ste. 2-175 Spokane, WA 99202
 *
 * ************************************************************************************* */


#import <UIKit/UIKit.h>
#import "WritePadInputView.h"
#import "WritePadInputPanel.h"
#import "Shortcuts.h"
#import "InkCollectorView.h"
#import "SuggestionsView.h"

typedef enum {
    InputSystem_Default = -1,
    InputSystem_InputPanel = 0,
    InputSystem_WriteAnywhere,
    InputSystem_Keyboard
} InputSystem;

@interface WPTextView : UITextView <WritePadInputPanelDelegate, WritePadInputViewDelegate, ShortcutsDelegate, InkCollectorViewDelegate, SuggestionsViewDelegate>
{
@private
    InkCollectorView * inkCollector;
}

+ (WPTextView *) createTextView:(CGRect)frame;

- (void) setInputMethod:(InputSystem)inputSystem;
- (void) processTouchAndHoldAtLocation:(CGPoint)location;
- (void) tapAtLocation:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) selectTextFromPosition:(CGPoint)from toPosition:(CGPoint)to;
- (void) hideSuggestions;
- (void) reloadOptions;
- (void) scrollToVisible;

@property (nonatomic, retain) InkCollectorView * inkCollector;
@property (nonatomic, readonly ) InputSystem  inputSystem;


@end
