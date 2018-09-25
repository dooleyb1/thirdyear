// Code taken from https://github.com/berryjam/leetcode-golang/blob/master/lowest-common-ancestor-of-a-binary-tree.go
package main

import (
	ds "github.com/berryjam/leetcode-golang/datastructure"
)

func LowestCommonAncestor(root, p, q *ds.TreeNode) *ds.TreeNode {
	if root.Left == nil && root.Right == nil {
		if isAncestor(root, p) && isAncestor(root, q) {
			return root
		} else {
			return nil
		}
	}

	if root.Left != nil {
		if isAncestor(root.Left, p) && isAncestor(root.Left, q) {
			return LowestCommonAncestor(root.Left, p, q)
		}
	}

	if root.Right != nil {
		if isAncestor(root.Right, p) && isAncestor(root.Right, q) {
			return LowestCommonAncestor(root.Right, p, q)
		}
	}

	if isAncestor(root, p) && isAncestor(root, q) {
		return root
	}

	return nil
}

func isAncestor(curNode, p *ds.TreeNode) bool {
	if curNode == p { // we allow a node to be a descendant of itself
		return true
	}

	leftRes := false
	if curNode.Left != nil {
		if curNode.Left == p {
			leftRes = true
		} else {
			leftRes = isAncestor(curNode.Left, p)
		}
	}

	rightRes := false
	if curNode.Right != nil {
		if curNode.Right == p {
			rightRes = true
		} else {
			rightRes = isAncestor(curNode.Right, p)
		}
	}

	return leftRes || rightRes
}
