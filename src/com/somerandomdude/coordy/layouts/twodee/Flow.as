﻿/*The MIT LicenseCopyright (c) 2009 P.J. Onori (pj@somerandomdude.com)Permission is hereby granted, free of charge, to any person obtaining a copyof this software and associated documentation files (the "Software"), to dealin the Software without restriction, including without limitation the rightsto use, copy, modify, merge, publish, distribute, sublicense, and/or sellcopies of the Software, and to permit persons to whom the Software isfurnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included inall copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS ORIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHERLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS INTHE SOFTWARE.*//** Credits: Much of the code written in this class was taken from the Yahoo! Astra library's FlowPane class found here:* http://developer.yahoo.com/flash/astra-flash/classreference/ */  /** * * * @author      P.J. Onori * @version     0.1 * @description * @url  */ package com.somerandomdude.coordy.layouts.twodee {	import com.somerandomdude.coordy.constants.FlowAlignment;	import com.somerandomdude.coordy.constants.FlowDirection;	import com.somerandomdude.coordy.constants.FlowOverflowPolicy;	import com.somerandomdude.coordy.constants.LayoutType;	import com.somerandomdude.coordy.nodes.twodee.FlowNode;	import com.somerandomdude.coordy.nodes.twodee.INode2d;	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.geom.Rectangle;	public class Flow extends Layout2d implements ILayout2d	{		private var _hPadding:Number=0;		private var _yPadding:Number=0;				private var _overflowPolicy:String=FlowOverflowPolicy.ALLOW_OVERFLOW;				private var _placementDirection:String=FlowDirection.HORIZONTAL;		private var _alignment:String=FlowAlignment.TOP_LEFT;				//temporary		private var horizontalAlign:String="top";		private var verticalAlign:String="left";				/**		 * Method in which layout aligns nodes withing the layout's bounds		 * 		 * @see com.somerandomdude.coordy.layouts.FlowAlignment		 * 		 * @return Align value in string format		 * 		 */				public function get align():String { return this._alignment; }		public function set align(value:String):void		{			switch(value)			{				case FlowAlignment.TOP_LEFT:					verticalAlign="top";					horizontalAlign="left";					break;				case FlowAlignment.TOP_CENTER:					verticalAlign="top";					horizontalAlign="center";					break;				case FlowAlignment.TOP_RIGHT:					verticalAlign="top";					horizontalAlign="right";					break;				case FlowAlignment.MIDDLE_LEFT:					verticalAlign="middle";					horizontalAlign="left";					break;				case FlowAlignment.MIDDLE_CENTER:					verticalAlign="middle";					horizontalAlign="center";					break;				case FlowAlignment.MIDDLE_RIGHT:					verticalAlign="middle";					horizontalAlign="right";					break;				case FlowAlignment.BOTTOM_LEFT:					verticalAlign="bottom";					horizontalAlign="left";					break;				case FlowAlignment.BOTTOM_CENTER:					verticalAlign="bottom";					horizontalAlign="center";					break;				case FlowAlignment.BOTTOM_RIGHT:					verticalAlign="bottom";					horizontalAlign="right";					break;				default:					verticalAlign="top";					horizontalAlign="left";					value=FlowAlignment.TOP_LEFT;					break;			}			this._alignment=value;			this._updateFunction();		}				/**		 * Direction in which the layout places nodes (horizontal or vertical)		 * 		 * @see com.somerandomdude.coordy.layouts.FlowDirection		 * 		 * @return String describing layout's placement direction		 * 		 */				public function get placementDirection():String { return this._placementDirection; }		public function set placementDirection(value:String):void		{			this._placementDirection=value;			this._updateFunction();		}				/**		 * The method in which the layout handles nodes that do not fit within the bounds of the layout		 * 		 * @see com.somerandomdude.coordy.layouts.FlowOverflowPolicy		 * 		 * @return String describing layout's overflow policy		 * 		 */				public function get overflowPolicy():String { return this._overflowPolicy; }		public function set overflowPolicy(policy:String):void		{			this._overflowPolicy=policy;			if(this._size>0) this._updateFunction();		}				/**		 * Accessor for y padding property		 *		 * @return	Y padding of grid cells for layout organizer   		 */		public function get paddingY():Number { return this._yPadding; }		public function set paddingY(value:Number):void		{			this._yPadding=value;			this._updateFunction();		}				/**		 * Accessor for x padding property		 *		 * @return	X padding of grid cells for layout organizer   		 */		public function get paddingX():Number { return this._hPadding; }		public function set paddingX(value:Number):void		{			this._hPadding=value;			this._updateFunction();		}				/**		 * Distributes nodes in a flow layout.		 * 		 * @param target		DisplayObjectContainer which parents all objects in the layout		 * @param width			Width of the flow layout		 * @param height		Height of the flow layout		 * @param hPadding		Horizontal padding of all nodes in the layout		 * @param vPadding		Vertical padding of all nodes in the layout		 * @param x				x position of the flow layout		 * @param y				y position of the flow layout		 * 		 */				public function Flow(target:DisplayObjectContainer, 							width:Number, 							height:Number, 							hPadding:Number=0, 							vPadding:Number=0, 							x:Number=0, 							y:Number=0):void		{			super(target);						this._width=width;			this._height=height;			this._hPadding=hPadding;			this._yPadding=vPadding;			this._x=x;			this._y=y;			this._nodes=new Array();		}				/**		 * Returns the type of layout in a string format		 * 		 * @see com.somerandomdude.coordy.layouts.LayoutType		 * @return Layout's type		 * 		 */		override public function toString():String { return LayoutType.FLOW; }				/**		 * Adds DisplayObject to layout in next available position		 *		 * @param  object  DisplayObject to add to layout		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance		 * 		 * @return newly created node object containing a link to the object		 */		override public function addToLayout(object:DisplayObject, moveToCoordinates:Boolean=true, addToStage:Boolean=true):INode2d		{			var node:FlowNode=new FlowNode();						node.link=object;			this.addNode(node);			this.update();						if(moveToCoordinates) this.render();			if(addToStage) this._target.addChild(object);						return node;		}				/**		* Clones the current object's properties (does not include links to DisplayObjects)		* 		* @return Flow clone of object		*/		override public function clone():ILayout2d		{			return new Flow(_target, _width, _height, paddingX, paddingY, _x, _y);		}				/**		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update		 * the actual objects linked to the layout.		 * 		 */			override public function update():void		{			(this._placementDirection==FlowDirection.HORIZONTAL)?this.layoutChildrenHorizontally(new Rectangle(this._x, this._y, this._width, this._height)):this.layoutChildrenVertically(new Rectangle(this._x, this._y, this._width, this._height)); 			if(this._overflowPolicy==FlowOverflowPolicy.HIDE_OVERFLOW)			{				for(var i:int=0; i<this._size; i++)				{					var c:FlowNode = this._nodes[i];					if(c.outsideBounds&&this._target.contains(c.link)) this._target.removeChild(c.link);					else if(!c.outsideBounds&&!this._target.contains(c.link)) this._target.addChild(c.link);				}			}							}				/**		 * @protected 		 * @param bounds		 * 		 */				protected function layoutChildrenHorizontally(bounds:Rectangle):void		{				const START_X:Number = bounds.x + 0;			var yPosition:Number = bounds.y + 0;			var xPosition:Number = START_X;			var maxChildHeight:Number = 0;			var row:Array = [];									for(var i:int = 0; i < this._size; i++)			{				var cell:FlowNode = this._nodes[i];				var child:DisplayObject = this._nodes[i].link;				var bb:Rectangle = child.getBounds(child);								//next column if we're over the height, but not if we're at yposition == bounds.y				var endOfRow:Number = xPosition + child.width + 0;								if(endOfRow - bounds.x >= bounds.width && xPosition != START_X)				{					//update alignment					this.alignRow(row, maxChildHeight, bounds);										yPosition += maxChildHeight + this._yPadding;					xPosition = START_X;					maxChildHeight = 0;					row = [];				}								cell.outsideBounds=(yPosition+child.height>bounds.height)?true:false;					cell.x = xPosition-bb.x;				cell.y = yPosition-bb.y;				row.push(cell);				maxChildHeight = Math.max(maxChildHeight, child.height);				xPosition += child.width + this._hPadding;			}			this.alignRow(row, maxChildHeight, bounds);		}				/**		 * @protected 		 * @param bounds		 * 		 */				protected function layoutChildrenVertically(bounds:Rectangle):void		{				const START_Y:Number = bounds.y + 0;			var xPosition:Number = bounds.x + 0;			var yPosition:Number = START_Y;			var maxChildWidth:Number = 0;			var column:Array = [];						for(var i:int = 0; i < this._size; i++)			{				var cell:FlowNode = this._nodes[i];				var child:DisplayObject = this._nodes[i].link;				var bb:Rectangle = child.getBounds(child);								var endOfColumn:Number = yPosition + child.height + 0;								if(endOfColumn - bounds.y >= bounds.height && yPosition != START_Y)				{					this.alignColumn(column, maxChildWidth, bounds);										xPosition += maxChildWidth + this._hPadding;										yPosition = START_Y;					maxChildWidth = 0;					column = [];				}					cell.outsideBounds=(xPosition+child.width>bounds.width)?true:false;					cell.x = xPosition-bb.x;				cell.y = yPosition-bb.y;				column.push(cell);				maxChildWidth = Math.max(maxChildWidth, child.width);				yPosition += child.height + this._yPadding;			}			this.alignColumn(column, maxChildWidth, bounds);		}				/**		 * @protected		 * @param column		 * @param maxChildWidth		 * @param bounds		 * 		 */				protected function alignColumn(column:Array, maxChildWidth:Number, bounds:Rectangle):void		{			if(column.length == 0) return;						var lastChild:FlowNode = column[column.length - 1];			var columnHeight:Number = (lastChild.y + lastChild.link.height) - bounds.y + /*this.paddingBottom*/0;			var difference:Number = bounds.height - columnHeight;						var columnCount:int = column.length;			for(var i:int = 0; i < columnCount; i++)			{				var child:FlowNode = column[i];								this.alignItems(child, new Rectangle(child.x, child.y, maxChildWidth, child.link.height), this.horizontalAlign, null);												switch(this.verticalAlign)				{					case "middle":						child.y += difference / 2;						break;					case "bottom":						child.y += difference;						break;				}							}		}				/**		 * @protected 		 * @param row		 * @param maxChildHeight		 * @param bounds		 * 		 */				protected function alignRow(row:Array, maxChildHeight:Number, bounds:Rectangle):void		{			if(row.length == 0) return;						var lastChild:FlowNode = row[row.length - 1];			var rowWidth:Number = (lastChild.x + lastChild.link.width) - bounds.x + /*this.paddingRight*/0;			var difference:Number = bounds.width - rowWidth;						var rowCount:int = row.length;			for(var i:int = 0; i < rowCount; i++)			{				var child:FlowNode = row[i];				this.alignItems(child, new Rectangle(child.x, child.y, child.link.width, maxChildHeight), null, this.verticalAlign);							switch(this.horizontalAlign)				{					case "center":						child.x += difference / 2;						break;					case "right":						child.x += difference;						break;				}			}		}				/**		 * @private 		 * @param target		 * @param bounds		 * @param horizontalAlign		 * @param verticalAlign		 * 		 */				private function alignItems(target:FlowNode, bounds:Rectangle, horizontalAlign:String = null, verticalAlign:String = null):void		{							var horizontalDifference:Number = bounds.width - target.link.width;			switch(horizontalAlign)			{				case "left":					target.x = bounds.x;					break;				case "center":					target.x = bounds.x + (horizontalDifference) / 2;					break;				case "right":					target.x = bounds.x + horizontalDifference;					break;			}								var verticalDifference:Number = bounds.height - target.link.height;						switch(verticalAlign)			{				case "top":					target.y = bounds.y;					break;				case "middle":					target.y = bounds.y + (verticalDifference) / 2;					break;				case "bottom":					target.y = bounds.y + verticalDifference;					break;			}		}	}}