import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
	public boolean checkString(String s) {
		return s.equalsIgnoreCase("moon");
	}
}

class IsA implements StringChecker {
	public boolean checkString(String s) {
		return s.equalsIgnoreCase("A");
	}
}

public class TestListExamples {
	
	
	@Test(timeout = 500)
	public void testMergeRightEnd() {
		List<String> left = Arrays.asList("a", "b", "c");
		List<String> right = Arrays.asList("a", "d");
		List<String> merged = ListExamples.merge(left, right);
		List<String> expected = Arrays.asList("a", "a", "b", "c", "d");

		assertEquals(expected, merged);
	}

	@Test(timeout = 500)
	public void testMergeLeftEnd(){
		List<String> left = Arrays.asList("a", "b", "c", "e");
		List<String> right = Arrays.asList("a", "c", "d");
		List<String> merged = ListExamples.merge(left, right);
		List<String> expected = Arrays.asList("a", "a", "b", "c", "c", "d", "e");

		assertEquals(expected, merged);
	}

	@Test(timeout = 500)
	public void testFilterA(){
		List<String> input = Arrays.asList("a", "b", "c", "A", "moon", "a", "7", "MOON", "*");
		List<String> output = ListExamples.filter(input, new IsA());
		String[] expected = {"a", "A", "a"};

		assertArrayEquals(expected, output.toArray());
	}

	@Test(timeout = 500)
	public void testFilterMoon(){
		List<String> input = Arrays.asList("a", "b", "c", "A", "moon", "a", "7", "MOON", "*");
		List<String> output = ListExamples.filter(input, new IsMoon());
		String[] expected = {"moon", "MOON"};

		assertArrayEquals(expected, output.toArray());
	}



}
